import Foundation

protocol ProfileInteractorInput: AnyObject {
    func loadProfile() async
    func logout() async
}

protocol ProfileInteractorOutput: AnyObject {
    func interactor(didLoad profile: ProfileEntity)
    func interactorDidLogout()
    func interactor(didFail error: AppFailure)
}

final class ProfileInteractor: ProfileInteractorInput {
    weak var output: ProfileInteractorOutput?
    private let repository: ProfileRepository
    private let logoutUseCase: LogoutUseCase

    init(repository: ProfileRepository, logoutUseCase: LogoutUseCase) {
        self.repository = repository
        self.logoutUseCase = logoutUseCase
    }

    func loadProfile() async {
        switch await repository.fetchProfile() {
        case .right(let p): await MainActor.run { output?.interactor(didLoad: p) }
        case .left(let f):  await MainActor.run { output?.interactor(didFail: f) }
        }
    }

    func logout() async {
        _ = await logoutUseCase(NoParams.value)
        await MainActor.run { output?.interactorDidLogout() }
    }
}
