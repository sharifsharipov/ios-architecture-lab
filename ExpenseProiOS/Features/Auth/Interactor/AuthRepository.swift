import Foundation

protocol AuthRepository {
    func sendOTP(phone: String) async -> FailureOr<Void>
    func verifyOTP(phone: String, code: String) async -> FailureOr<UserEntity>
    func logout() async -> FailureOr<Void>
    func currentUser() async -> FailureOr<UserEntity?>
}
