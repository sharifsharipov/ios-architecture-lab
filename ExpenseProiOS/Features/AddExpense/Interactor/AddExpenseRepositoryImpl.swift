import Foundation

final class AddExpenseRepositoryImpl: AddExpenseRepository {
    private let provider: SupabaseProvider
    init(provider: SupabaseProvider) { self.provider = provider }

    func save(_ draft: ExpenseDraft) async -> FailureOr<TransactionEntity> {
        let tx = TransactionEntity(
            id: UUID().uuidString,
            title: draft.title,
            amount: draft.amount,
            currency: draft.currency,
            kind: draft.kind,
            date: draft.date,
            category: draft.category,
            note: draft.note
        )
        return .right(tx)
    }

    func update(id: String, _ draft: ExpenseDraft) async -> FailureOr<TransactionEntity> {
        let tx = TransactionEntity(
            id: id,
            title: draft.title,
            amount: draft.amount,
            currency: draft.currency,
            kind: draft.kind,
            date: draft.date,
            category: draft.category,
            note: draft.note
        )
        return .right(tx)
    }
}
