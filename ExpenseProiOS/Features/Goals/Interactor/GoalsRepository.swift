import Foundation

protocol GoalsRepository {
    func fetchAll() async -> FailureOr<[GoalEntity]>
    func fetch(id: String) async -> FailureOr<GoalEntity>
    func save(_ goal: GoalEntity) async -> FailureOr<GoalEntity>
    func delete(id: String) async -> FailureOr<Void>
}
