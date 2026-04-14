import SwiftUI

@MainActor
enum ProfileBuilder {
    static func build(appRouter: AppRouter) -> some View {
        let di = DIContainer.shared
        let interactor = ProfileInteractor(
            repository: di.resolve(ProfileRepository.self),
            logoutUseCase: di.resolve(LogoutUseCase.self)
        )
        let router = ProfileRouter(appRouter: appRouter)
        let presenter = ProfilePresenter(interactor: interactor, router: router)
        interactor.output = presenter
        return ProfileView(presenter: presenter)
    }
}
