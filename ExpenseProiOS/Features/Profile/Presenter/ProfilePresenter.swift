import Foundation

struct ProfileViewState: Equatable {
    enum Phase: Equatable { case idle, loading, loaded, error(String) }
    var phase: Phase = .idle
    var profile: ProfileEntity?
}

@MainActor
final class ProfilePresenter: ObservableObject, ProfileInteractorOutput {
    @Published private(set) var state = ProfileViewState()

    private let interactor: ProfileInteractorInput
    private let router: ProfileRouterInput

    init(interactor: ProfileInteractorInput, router: ProfileRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    func onAppear() {
        guard state.phase == .idle else { return }
        Task { await refresh() }
    }

    func refresh() async {
        state.phase = .loading
        await interactor.loadProfile()
    }

    func didTapLogout() { Task { await interactor.logout() } }

    // Router shortcuts
    func didTapUserInfo() { router.openUserInfo() }
    func didTapTheme() { router.openTheme() }
    func didTapLanguage() { router.openLanguage() }
    func didTapNotifications() { router.openNotifications() }
    func didTapHabits() { router.openHabits() }
    func didTapAchievements() { router.openAchievements() }
    func didTapSubscription() { router.openSubscription() }
    func didTapAutomationsRules() { router.openAutomationsRules() }
    func didTapAboutApplication() { router.openAboutApplication() }

    // Interactor output
    nonisolated func interactor(didLoad profile: ProfileEntity) {
        Task { @MainActor in
            state.profile = profile
            state.phase = .loaded
        }
    }

    nonisolated func interactorDidLogout() {
        // AuthSession signOut Interactor ichida chaqirilishi kerak — hozir LogoutUseCase'da.
    }

    nonisolated func interactor(didFail error: AppFailure) {
        Task { @MainActor in state.phase = .error(error.message) }
    }
}
