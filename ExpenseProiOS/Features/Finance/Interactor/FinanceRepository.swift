import Foundation

protocol FinanceRepository {
    func fetchAll() async -> FailureOr<[FinanceRecordEntity]>
    func fetch(id: String) async -> FailureOr<FinanceRecordEntity>
}
