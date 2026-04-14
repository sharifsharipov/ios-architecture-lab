import Foundation

protocol HomeRepository {
    func fetchSummary() async -> FailureOr<HomeSummary>
    func fetchTransaction(id: String) async -> FailureOr<TransactionEntity>
}
