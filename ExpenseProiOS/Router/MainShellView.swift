import SwiftUI

struct MainShellView: View {
    @StateObject private var router = AppRouter.shared

    var body: some View {
        TabView(selection: $router.selectedTab) {
            tabStack(path: $router.homePath) {
                HomeBuilder.build(appRouter: router)
            }
            .tabItem { Label(String(localized: "home"), systemImage: MainTab.home.iconName) }
            .tag(MainTab.home)

            tabStack(path: $router.financePath) {
                FinanceBuilder.build(appRouter: router)
            }
            .tabItem { Label(String(localized: "finance"), systemImage: MainTab.finance.iconName) }
            .tag(MainTab.finance)

            tabStack(path: $router.goalsPath) {
                GoalsBuilder.build(appRouter: router)
            }
            .tabItem { Label(String(localized: "goals"), systemImage: MainTab.goals.iconName) }
            .tag(MainTab.goals)

            tabStack(path: $router.profilePath) {
                ProfileBuilder.build(appRouter: router)
            }
            .tabItem { Label(String(localized: "profile"), systemImage: MainTab.profile.iconName) }
            .tag(MainTab.profile)
        }
        .environmentObject(router)
    }

    @ViewBuilder
    private func tabStack<Content: View>(
        path: Binding<NavigationPath>,
        @ViewBuilder root: () -> Content
    ) -> some View {
        NavigationStack(path: path) {
            root()
                .navigationDestination(for: AppRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }
}
