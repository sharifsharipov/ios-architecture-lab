import Foundation

protocol AddExpenseRepository {
    func save(_ draft: ExpenseDraft) async -> FailureOr<TransactionEntity>
    func update(id: String, _ draft: ExpenseDraft) async -> FailureOr<TransactionEntity>
}
