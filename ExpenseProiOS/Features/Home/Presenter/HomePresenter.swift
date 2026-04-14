import Foundation
import SwiftUI

// MARK: - VIPER: Presenter
// View <-> Interactor o'rtasidagi ko'prik. ViewState'ni tayyorlaydi, user actionlarini qabul qiladi.

struct HomeViewState: Equatable {
    enum Phase: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }

    var phase: Phase = .idle
    var summary: HomeSummary = .empty
}

@MainActor
final class HomePresenter: ObservableObject, HomeInteractorOutput {
    @Published private(set) var state = HomeViewState()

    private let interactor: HomeInteractorInput
    private let router: HomeRouterInput

    init(interactor: HomeInteractorInput, router: HomeRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - View events

    func onAppear() {
        guard state.phase == .idle else { return }
        Task { await refresh() }
    }

    func refresh() async {
        state.phase = .loading
        await interactor.loadSummary()
    }

    func didTapAddExpense() {
        router.openAddExpense()
    }

    func didTapTransaction(_ id: String) {
        router.openTransaction(id: id)
    }

    // MARK: - Interactor output

    nonisolated func interactor(didLoad summary: HomeSummary) {
        Task { @MainActor in
            self.state.summary = summary
            self.state.phase = .loaded
        }
    }

    nonisolated func interactor(didLoad transaction: TransactionEntity) {
        // Home sahifasi bitta tranzaksiya yuklashni ishlatmaydi, no-op
    }

    nonisolated func interactor(didFail error: AppFailure) {
        Task { @MainActor in
            self.state.phase = .error(error.message)
        }
    }
}
