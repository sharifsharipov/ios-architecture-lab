import Foundation
import Supabase

protocol AuthDataSource {
    func sendOTP(phone: String) async throws
    func verifyOTP(phone: String, code: String) async throws -> UserModel
    func logout() async throws
    func currentUser() async throws -> UserModel?
}

final class AuthRemoteDataSource: AuthDataSource {
    private let supabase: SupabaseClient

    init(provider: SupabaseProvider) {
        self.supabase = provider.client
    }

    func sendOTP(phone: String) async throws {
        try await supabase.auth.signInWithOTP(phone: phone)
    }

    func verifyOTP(phone: String, code: String) async throws -> UserModel {
        let session = try await supabase.auth.verifyOTP(phone: phone, token: code, type: .sms)
        let user = session.user
        return UserModel(
            id: user.id.uuidString,
            phone: user.phone ?? phone,
            email: user.email,
            name: user.userMetadata["name"]?.stringValue,
            avatarURL: user.userMetadata["avatar_url"]?.stringValue,
            gender: user.userMetadata["gender"]?.stringValue
        )
    }

    func logout() async throws {
        try await supabase.auth.signOut()
    }

    func currentUser() async throws -> UserModel? {
        guard let user = supabase.auth.currentUser else { return nil }
        return UserModel(
            id: user.id.uuidString,
            phone: user.phone ?? "",
            email: user.email,
            name: user.userMetadata["name"]?.stringValue,
            avatarURL: user.userMetadata["avatar_url"]?.stringValue,
            gender: user.userMetadata["gender"]?.stringValue
        )
    }
}
