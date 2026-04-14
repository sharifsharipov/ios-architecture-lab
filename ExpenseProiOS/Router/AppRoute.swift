import Foundation

// Flutter `Routes` sealed class ekvivalenti. NavigationStack path qiymati.

enum AppRoute: Hashable {
    // Auth
    case auth
    case login

    // Home
    case homeDescription(id: String)

    // Add expense
    case addExpense(editingId: String?)

    // Goals
    case goalsDescription(id: String)

    // Finance
    case financeDescription(id: String)

    // Profile sub-pages
    case settings
    case achievements
    case notifications
    case habits
    case subscription
    case language
    case theme
    case userInfo
    case automationsRules
    case aboutApplication
}

enum MainTab: Int, CaseIterable, Identifiable {
    case home = 0, finance, goals, profile
    var id: Int { rawValue }

    var titleKey: String.LocalizationValue {
        switch self {
        case .home: return "home"
        case .finance: return "finance"
        case .goals: return "goals"
        case .profile: return "profile"
        }
    }

    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .finance: return "chart.pie.fill"
        case .goals: return "target"
        case .profile: return "person.crop.circle.fill"
        }
    }
}
