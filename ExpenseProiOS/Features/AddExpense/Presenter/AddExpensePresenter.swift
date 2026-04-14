import Foundation

struct AddExpenseViewState: Equatable {
    var draft: ExpenseDraft = .init()
    var isSaving: Bool = false
    var errorMessage: String?
    var didSave: Bool = false
}

@MainActor
final class AddExpensePresenter: ObservableObject, AddExpenseInteractorOutput {
    @Published var state = AddExpenseViewState()

    let editingId: String?
    private let interactor: AddExpenseInteractorInput
    private let router: AddExpenseRouterInput

    init(editingId: String?, interactor: AddExpenseInteractorInput, router: AddExpenseRouterInput) {
        self.editingId = editingId
        self.interactor = interactor
        self.router = router
    }

    func didTapSave() {
        guard !state.draft.title.isEmpty, state.draft.amount > 0 else {
            state.errorMessage = "Ma'lumotlarni to'liq kiriting"
            return
        }
        state.isSaving = true
        state.errorMessage = nil
        Task { await interactor.save(state.draft, editingId: editingId) }
    }

    nonisolated func interactor(didSave transaction: TransactionEntity) {
        Task { @MainActor in
            state.isSaving = false
            state.didSave = true
            router.dismiss()
        }
    }

    nonisolated func interactor(didFail error: AppFailure) {
        Task { @MainActor in
            state.isSaving = false
            state.errorMessage = error.message
        }
    }
}
