import SwiftUI

struct ProfileView: View {
    @StateObject private var presenter: ProfilePresenter

    init(presenter: ProfilePresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        List {
            Section { header }
            Section(String(localized: "settings")) {
                row("userInformation", icon: "person.fill", action: presenter.didTapUserInfo)
                row("theme", icon: "paintbrush.fill", action: presenter.didTapTheme)
                row("language", icon: "globe", action: presenter.didTapLanguage)
                row("notifications", icon: "bell.fill", action: presenter.didTapNotifications)
            }
            Section {
                row("habits", icon: "chart.bar.fill", action: presenter.didTapHabits)
                row("achievements", icon: "trophy.fill", action: presenter.didTapAchievements)
                row("subscriptions", icon: "creditcard.fill", action: presenter.didTapSubscription)
                row("automationsRules", icon: "wand.and.stars", action: presenter.didTapAutomationsRules)
            }
            Section {
                row("aboutApplication", icon: "info.circle.fill", action: presenter.didTapAboutApplication)
                Button(role: .destructive, action: presenter.didTapLogout) {
                    Label(String(localized: "logout"), systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .navigationTitle(String(localized: "profile"))
        .onAppear { presenter.onAppear() }
        .refreshable { await presenter.refresh() }
    }

    @ViewBuilder
    private var header: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: "person.crop.circle.fill")
                .resizable().frame(width: 56, height: 56)
                .foregroundStyle(AppTheme.accent)
            VStack(alignment: .leading) {
                Text(presenter.state.profile?.user.name ?? "—").font(.headline)
                Text(presenter.state.profile?.user.phone ?? "").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
    }

    private func row(_ key: String.LocalizationValue, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(String(localized: key), systemImage: icon)
        }
        .foregroundStyle(AppTheme.textPrimary)
    }
}

// MARK: - Profile sub-pages (skeleton)

struct SettingsView: View {
    var body: some View { Text("Settings").navigationTitle(String(localized: "settings")) }
}

struct AchievementsView: View {
    var body: some View { Text("Achievements").navigationTitle(String(localized: "achievements")) }
}

struct NotificationsView: View {
    var body: some View { Text("Notifications").navigationTitle(String(localized: "notifications")) }
}

struct HabitsView: View {
    var body: some View { Text("Habits").navigationTitle(String(localized: "habits")) }
}

struct SubscriptionView: View {
    var body: some View { Text("Subscription").navigationTitle(String(localized: "subscription")) }
}

struct LanguageView: View {
    @EnvironmentObject private var options: AppOptions
    var body: some View {
        List(AppLanguage.allCases, id: \.self) { lang in
            Button {
                options.language = lang
            } label: {
                HStack {
                    Text(lang.displayName)
                    Spacer()
                    if options.language == lang {
                        Image(systemName: "checkmark").foregroundStyle(AppTheme.accent)
                    }
                }
            }
            .foregroundStyle(AppTheme.textPrimary)
        }
        .navigationTitle(String(localized: "language"))
    }
}

struct ThemeView: View {
    @EnvironmentObject private var options: AppOptions
    var body: some View {
        List(AppThemeMode.allCases, id: \.self) { mode in
            Button {
                options.themeMode = mode
            } label: {
                HStack {
                    Text(String(localized: String.LocalizationValue(mode.title)))
                    Spacer()
                    if options.themeMode == mode {
                        Image(systemName: "checkmark").foregroundStyle(AppTheme.accent)
                    }
                }
            }
            .foregroundStyle(AppTheme.textPrimary)
        }
        .navigationTitle(String(localized: "theme"))
    }
}

struct UserInfoView: View {
    var body: some View { Text("User info").navigationTitle(String(localized: "userInformation")) }
}

struct AutomationsRulesView: View {
    var body: some View { Text("Automations").navigationTitle(String(localized: "automationsRules")) }
}

struct AboutApplicationView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "creditcard.circle.fill").font(.system(size: 64))
                .foregroundStyle(AppTheme.accent)
            Text("ExpensePro").font(.title.bold())
            Text("v1.0.0").foregroundStyle(.secondary)
        }
        .navigationTitle(String(localized: "aboutApplication"))
    }
}
