import Foundation

struct GoalsViewState: Equatable {
    enum Phase: Equatable { case idle, loading, loaded, error(String) }
    var phase: Phase = .idle
    var goals: [GoalEntity] = []
}

@MainActor
final class GoalsPresenter: ObservableObject, GoalsInteractorOutput {
    @Published private(set) var state = GoalsViewState()

    private let interactor: GoalsInteractorInput
    private let router: GoalsRouterInput

    init(interactor: GoalsInteractorInput, router: GoalsRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    func onAppear() {
        guard state.phase == .idle else { return }
        Task { await refresh() }
    }

    func refresh() async {
        state.phase = .loading
        await interactor.loadGoals()
    }

    func didTapGoal(_ id: String) {
        router.openDetail(id: id)
    }

    nonisolated func interactor(didLoad goals: [GoalEntity]) {
        Task { @MainActor in
            state.goals = goals
            state.phase = .loaded
        }
    }

    nonisolated func interactor(didFail error: AppFailure) {
        Task { @MainActor in state.phase = .error(error.message) }
    }
}
