import SwiftUI

struct RootView: View {
    @EnvironmentObject var authSession: AuthSession

    var body: some View {
        Group {
            if authSession.isAuthenticated {
                MainShellView()
            } else {
                AuthCoordinatorView()
            }
        }
        .animation(.easeInOut, value: authSession.isAuthenticated)
    }
}

#Preview {
    RootView()
        .environmentObject(AppOptions.load())
        .environmentObject(AuthSession())
}
