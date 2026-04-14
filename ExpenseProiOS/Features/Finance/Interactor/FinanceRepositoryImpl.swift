import Foundation

final class FinanceRepositoryImpl: FinanceRepository {
    private let provider: SupabaseProvider

    init(provider: SupabaseProvider) { self.provider = provider }

    func fetchAll() async -> FailureOr<[FinanceRecordEntity]> { .right([]) }
    func fetch(id: String) async -> FailureOr<FinanceRecordEntity> {
        .left(UnknownFailure("Not implemented"))
    }
}
