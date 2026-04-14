import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let remote: AuthDataSource
    private let session: AuthSession

    init(remote: AuthDataSource, session: AuthSession) {
        self.remote = remote
        self.session = session
    }

    func sendOTP(phone: String) async -> FailureOr<Void> {
        do {
            try await remote.sendOTP(phone: phone)
            return .right(())
        } catch {
            return .left(ServerFailure(message: error.localizedDescription))
        }
    }

    func verifyOTP(phone: String, code: String) async -> FailureOr<UserEntity> {
        do {
            let model = try await remote.verifyOTP(phone: phone, code: code)
            return .right(model.toEntity())
        } catch {
            return .left(ServerFailure(message: error.localizedDescription))
        }
    }

    func logout() async -> FailureOr<Void> {
        do {
            try await remote.logout()
            await MainActor.run { session.signOut() }
            return .right(())
        } catch {
            return .left(ServerFailure(message: error.localizedDescription))
        }
    }

    func currentUser() async -> FailureOr<UserEntity?> {
        do {
            let model = try await remote.currentUser()
            return .right(model?.toEntity())
        } catch {
            return .left(ServerFailure(message: error.localizedDescription))
        }
    }
}
