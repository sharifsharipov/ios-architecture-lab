import Foundation

protocol AddExpenseInteractorInput: AnyObject {
    func save(_ draft: ExpenseDraft, editingId: String?) async
}

protocol AddExpenseInteractorOutput: AnyObject {
    func interactor(didSave transaction: TransactionEntity)
    func interactor(didFail error: AppFailure)
}

final class AddExpenseInteractor: AddExpenseInteractorInput {
    weak var output: AddExpenseInteractorOutput?
    private let repository: AddExpenseRepository

    init(repository: AddExpenseRepository) { self.repository = repository }

    func save(_ draft: ExpenseDraft, editingId: String?) async {
        let r: FailureOr<TransactionEntity>
        if let id = editingId {
            r = await repository.update(id: id, draft)
        } else {
            r = await repository.save(draft)
        }
        switch r {
        case .right(let tx): await MainActor.run { output?.interactor(didSave: tx) }
        case .left(let f):   await MainActor.run { output?.interactor(didFail: f) }
        }
    }
}
