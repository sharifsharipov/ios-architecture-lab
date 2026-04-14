import SwiftUI
import Combine

enum AppThemeMode: String, CaseIterable, Codable {
    case system, light, dark

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    var title: String {
        switch self {
        case .system: return "system"
        case .light: return "light"
        case .dark: return "dark"
        }
    }
}

enum AppLanguage: String, CaseIterable, Codable {
    case en, ru, uz, fr

    var locale: Locale { Locale(identifier: rawValue) }

    var displayName: String {
        switch self {
        case .en: return "English"
        case .ru: return "Русский"
        case .uz: return "O'zbekcha"
        case .fr: return "Français"
        }
    }
}

final class AppOptions: ObservableObject {
    @Published var themeMode: AppThemeMode {
        didSet { save() }
    }
    @Published var language: AppLanguage {
        didSet { save() }
    }

    private static let themeKey = "app.theme.mode"
    private static let langKey = "app.language"

    init(themeMode: AppThemeMode = .system, language: AppLanguage = .en) {
        self.themeMode = themeMode
        self.language = language
    }

    static func load() -> AppOptions {
        let defaults = UserDefaults.standard
        let theme = AppThemeMode(rawValue: defaults.string(forKey: themeKey) ?? "") ?? .system
        let lang = AppLanguage(rawValue: defaults.string(forKey: langKey) ?? "") ?? .en
        return AppOptions(themeMode: theme, language: lang)
    }

    private func save() {
        let defaults = UserDefaults.standard
        defaults.set(themeMode.rawValue, forKey: Self.themeKey)
        defaults.set(language.rawValue, forKey: Self.langKey)
    }
}
