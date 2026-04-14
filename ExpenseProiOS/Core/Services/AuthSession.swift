import Foundation
import Combine

// Global sessiya holati. Flutter'da BLoC va `LocalSource` bu rolni birgalikda bajaradi.

final class AuthSession: ObservableObject {
    @Published private(set) var isAuthenticated: Bool

    private let local: LocalSourceProtocol

    init(local: LocalSourceProtocol = LocalSource()) {
        self.local = local
        self.isAuthenticated = true
    }

    func signIn(accessToken: String, refreshToken: String?) {
        var local = self.local
        local.accessToken = accessToken
        local.refreshToken = refreshToken
        isAuthenticated = true
    }

    func signOut() {
        local.clear()
        isAuthenticated = false
    }
}
