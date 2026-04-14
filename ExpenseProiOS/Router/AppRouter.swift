import SwiftUI

// Har bir tab uchun alohida NavigationPath. Flutter `StatefulShellRoute.indexedStack` ekvivalenti.

// Flutter GoRouter config ekvivalenti:
//   navigatorKey        -> AppRouter.shared (global access)
//   initialLocation     -> AppRouter.initialTab + initialStack
//   debugLogDiagnostics -> AppRouter.debugLogDiagnostics

@MainActor
final class AppRouter: ObservableObject {
    static let shared = AppRouter()

    static var initialTab: MainTab = .home
    static var initialStack: [AppRoute] = []
    static var debugLogDiagnostics: Bool = true

    @Published var selectedTab: MainTab
    @Published var homePath: NavigationPath
    @Published var financePath = NavigationPath()
    @Published var goalsPath = NavigationPath()
    @Published var profilePath = NavigationPath()

    init() {
        self.selectedTab = Self.initialTab
        var path = NavigationPath()
        for route in Self.initialStack { path.append(route) }
        switch Self.initialTab {
        case .home: self.homePath = path
        case .finance: self.homePath = NavigationPath(); self.financePath = path
        case .goals: self.homePath = NavigationPath(); self.goalsPath = path
        case .profile: self.homePath = NavigationPath(); self.profilePath = path
        }
        log("init -> tab=\(Self.initialTab), stack=\(Self.initialStack)")
    }

    func push(_ route: AppRoute, in tab: MainTab? = nil) {
        let target = tab ?? selectedTab
        log("push \(route) in \(target)")
        switch target {
        case .home: homePath.append(route)
        case .finance: financePath.append(route)
        case .goals: goalsPath.append(route)
        case .profile: profilePath.append(route)
        }
    }

    func popToRoot(tab: MainTab? = nil) {
        let target = tab ?? selectedTab
        log("popToRoot \(target)")
        switch target {
        case .home: homePath = NavigationPath()
        case .finance: financePath = NavigationPath()
        case .goals: goalsPath = NavigationPath()
        case .profile: profilePath = NavigationPath()
        }
    }

    func go(to tab: MainTab) {
        log("go -> \(tab)")
        selectedTab = tab
    }

    private func log(_ message: String) {
        guard Self.debugLogDiagnostics else { return }
        print("[AppRouter] \(message)")
    }
}

@MainActor
@ViewBuilder
func destinationView(for route: AppRoute) -> some View {
    switch route {
    case .auth: AuthBuilder.build()
    case .login: LoginView()
    case .homeDescription(let id): HomeDescriptionView(id: id)
    case .addExpense(let id): AddExpenseBuilder.build(editingId: id)
    case .goalsDescription(let id): GoalsDescriptionView(id: id)
    case .financeDescription(let id): FinanceDescriptionView(id: id)
    case .settings: SettingsView()
    case .achievements: AchievementsView()
    case .notifications: NotificationsView()
    case .habits: HabitsView()
    case .subscription: SubscriptionView()
    case .language: LanguageView()
    case .theme: ThemeView()
    case .userInfo: UserInfoView()
    case .automationsRules: AutomationsRulesView()
    case .aboutApplication: AboutApplicationView()
    }
}
