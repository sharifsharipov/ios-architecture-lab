import Foundation

struct SendOTPUseCase: UseCase {
    struct Params { let phone: String }
    let repository: AuthRepository

    func callAsFunction(_ params: Params) async -> FailureOr<Void> {
        await repository.sendOTP(phone: params.phone)
    }
}

struct VerifyOTPUseCase: UseCase {
    struct Params { let phone: String; let code: String }
    let repository: AuthRepository

    func callAsFunction(_ params: Params) async -> FailureOr<UserEntity> {
        await repository.verifyOTP(phone: params.phone, code: params.code)
    }
}

struct LogoutUseCase: UseCase {
    let repository: AuthRepository

    func callAsFunction(_ params: NoParams) async -> FailureOr<Void> {
        await repository.logout()
    }
}
