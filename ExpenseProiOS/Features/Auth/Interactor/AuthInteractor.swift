import Foundation

protocol AuthInteractorInput: AnyObject {
    func sendCode(phone: String) async
    func verify(phone: String, code: String) async
}

protocol AuthInteractorOutput: AnyObject {
    func interactor(didSendCodeTo phone: String)
    func interactor(didAuthenticate user: UserEntity)
    func interactor(didFail error: AppFailure)
}

final class AuthInteractor: AuthInteractorInput {
    weak var output: AuthInteractorOutput?

    private let sendOTP: SendOTPUseCase
    private let verifyOTP: VerifyOTPUseCase
    private let session: AuthSession

    init(sendOTP: SendOTPUseCase, verifyOTP: VerifyOTPUseCase, session: AuthSession) {
        self.sendOTP = sendOTP
        self.verifyOTP = verifyOTP
        self.session = session
    }

    func sendCode(phone: String) async {
        let r = await sendOTP(.init(phone: phone))
        switch r {
        case .right: await MainActor.run { output?.interactor(didSendCodeTo: phone) }
        case .left(let f): await MainActor.run { output?.interactor(didFail: f) }
        }
    }

    func verify(phone: String, code: String) async {
        let r = await verifyOTP(.init(phone: phone, code: code))
        switch r {
        case .right(let user):
            await MainActor.run {
                self.session.signIn(accessToken: "supabase-managed", refreshToken: nil)
                self.output?.interactor(didAuthenticate: user)
            }
        case .left(let f):
            await MainActor.run { output?.interactor(didFail: f) }
        }
    }
}
