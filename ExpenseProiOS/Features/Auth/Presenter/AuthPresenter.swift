import Foundation

struct AuthViewState: Equatable {
    enum Step { case enterPhone, enterCode }
    var step: Step = .enterPhone
    var phone: String = ""
    var code: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
}

@MainActor
final class AuthPresenter: ObservableObject, AuthInteractorOutput {
    @Published var state = AuthViewState()

    private let interactor: AuthInteractorInput
    private let router: AuthRouterInput

    init(interactor: AuthInteractorInput, router: AuthRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - View events

    func didTapRequestCode() {
        guard !state.phone.isEmpty else {
            state.errorMessage = "Telefon raqamini kiriting"
            return
        }
        state.isLoading = true
        state.errorMessage = nil
        Task { await interactor.sendCode(phone: state.phone) }
    }

    func didTapVerify() {
        guard state.code.count >= 4 else {
            state.errorMessage = "Kodni kiriting"
            return
        }
        state.isLoading = true
        state.errorMessage = nil
        Task { await interactor.verify(phone: state.phone, code: state.code) }
    }

    // MARK: - Interactor output

    nonisolated func interactor(didSendCodeTo phone: String) {
        Task { @MainActor in
            state.isLoading = false
            state.step = .enterCode
        }
    }

    nonisolated func interactor(didAuthenticate user: UserEntity) {
        Task { @MainActor in
            state.isLoading = false
        }
    }

    nonisolated func interactor(didFail error: AppFailure) {
        Task { @MainActor in
            state.isLoading = false
            state.errorMessage = error.message
        }
    }
}
