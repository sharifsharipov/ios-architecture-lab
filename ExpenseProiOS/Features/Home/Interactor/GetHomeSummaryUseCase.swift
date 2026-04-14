import Foundation

struct GetHomeSummaryUseCase: UseCase {
    let repository: HomeRepository
    func callAsFunction(_ params: NoParams) async -> FailureOr<HomeSummary> {
        await repository.fetchSummary()
    }
}
