import Foundation

struct FinanceViewState: Equatable {
    enum Phase: Equatable { case idle, loading, loaded, error(String) }
    var phase: Phase = .idle
    var records: [FinanceRecordEntity] = []
}

@MainActor
final class FinancePresenter: ObservableObject, FinanceInteractorOutput {
    @Published private(set) var state = FinanceViewState()

    private let interactor: FinanceInteractorInput
    private let router: FinanceRouterInput

    init(interactor: FinanceInteractorInput, router: FinanceRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    func onAppear() {
        guard state.phase == .idle else { return }
        Task { await refresh() }
    }

    func refresh() async {
        state.phase = .loading
        await interactor.loadRecords()
    }

    func didTapRecord(_ id: String) {
        router.openDetail(id: id)
    }

    nonisolated func interactor(didLoad records: [FinanceRecordEntity]) {
        Task { @MainActor in
            state.records = records
            state.phase = .loaded
        }
    }

    nonisolated func interactor(didFail error: AppFailure) {
        Task { @MainActor in state.phase = .error(error.message) }
    }
}
