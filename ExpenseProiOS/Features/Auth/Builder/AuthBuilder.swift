import SwiftUI

@MainActor
enum AuthBuilder {
    static func build() -> some View {
        let di = DIContainer.shared
        let interactor = AuthInteractor(
            sendOTP: di.resolve(SendOTPUseCase.self),
            verifyOTP: di.resolve(VerifyOTPUseCase.self),
            session: di.resolve(AuthSession.self)
        )
        let router = AuthRouter()
        let presenter = AuthPresenter(interactor: interactor, router: router)
        interactor.output = presenter
        return AuthView(presenter: presenter)
    }
}
