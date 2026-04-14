import Foundation
import KeychainAccess

// Flutter `LocalSource` (Hive) ekvivalenti.
// Xavfsiz ma'lumotlar (token) → Keychain, oddiy sozlamalar → UserDefaults.

protocol LocalSourceProtocol {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
    var isOnboardingCompleted: Bool { get set }
    var isProfileFilled: Bool { get set }
    func clear()
}

final class LocalSource: LocalSourceProtocol {
    private let keychain: Keychain
    private let defaults: UserDefaults

    init(service: String = "com.expensepro.ios", defaults: UserDefaults = .standard) {
        self.keychain = Keychain(service: service)
        self.defaults = defaults
    }

    var accessToken: String? {
        get { keychain["access_token"] }
        set { keychain["access_token"] = newValue }
    }

    var refreshToken: String? {
        get { keychain["refresh_token"] }
        set { keychain["refresh_token"] = newValue }
    }

    var isOnboardingCompleted: Bool {
        get { defaults.bool(forKey: "is_onboarding_completed") }
        set { defaults.set(newValue, forKey: "is_onboarding_completed") }
    }

    var isProfileFilled: Bool {
        get { defaults.bool(forKey: "is_profile_filled") }
        set { defaults.set(newValue, forKey: "is_profile_filled") }
    }

    func clear() {
        try? keychain.removeAll()
        ["is_profile_filled"].forEach { defaults.removeObject(forKey: $0) }
    }
}
