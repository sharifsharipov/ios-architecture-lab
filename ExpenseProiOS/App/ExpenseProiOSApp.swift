import SwiftUI

@main
struct ExpenseProiOSApp: App {
    @StateObject private var appOptions = AppOptions.load()
    @StateObject private var authSession = AuthSession()

    init() {
        DIContainer.shared.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appOptions)
                .environmentObject(authSession)
                .preferredColorScheme(appOptions.themeMode.colorScheme)
                .environment(\.locale, appOptions.language.locale)
                .tint(AppTheme.accent)
        }
    }
}
