import Foundation

protocol ProfileRouterInput: AnyObject {
    func openSettings()
    func openAchievements()
    func openNotifications()
    func openHabits()
    func openSubscription()
    func openLanguage()
    func openTheme()
    func openUserInfo()
    func openAutomationsRules()
    func openAboutApplication()
}

@MainActor
final class ProfileRouter: ProfileRouterInput {
    weak var appRouter: AppRouter?
    init(appRouter: AppRouter) { self.appRouter = appRouter }

    private func push(_ route: AppRoute) {
        appRouter?.push(route, in: .profile)
    }

    func openSettings() { push(.settings) }
    func openAchievements() { push(.achievements) }
    func openNotifications() { push(.notifications) }
    func openHabits() { push(.habits) }
    func openSubscription() { push(.subscription) }
    func openLanguage() { push(.language) }
    func openTheme() { push(.theme) }
    func openUserInfo() { push(.userInfo) }
    func openAutomationsRules() { push(.automationsRules) }
    func openAboutApplication() { push(.aboutApplication) }
}
