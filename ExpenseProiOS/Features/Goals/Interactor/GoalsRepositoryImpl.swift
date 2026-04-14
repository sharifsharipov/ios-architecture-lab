import Foundation

final class GoalsRepositoryImpl: GoalsRepository {
    private let provider: SupabaseProvider
    init(provider: SupabaseProvider) { self.provider = provider }

    func fetchAll() async -> FailureOr<[GoalEntity]> { .right([]) }
    func fetch(id: String) async -> FailureOr<GoalEntity> {
        .left(UnknownFailure("Not implemented"))
    }
    func save(_ goal: GoalEntity) async -> FailureOr<GoalEntity> { .right(goal) }
    func delete(id: String) async -> FailureOr<Void> { .right(()) }
}
