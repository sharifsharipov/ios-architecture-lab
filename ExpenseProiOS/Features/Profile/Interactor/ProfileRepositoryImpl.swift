import Foundation

final class ProfileRepositoryImpl: ProfileRepository {
    private let provider: SupabaseProvider
    init(provider: SupabaseProvider) { self.provider = provider }

    func fetchProfile() async -> FailureOr<ProfileEntity> {
        .left(UnknownFailure("Not implemented"))
    }
    func fetchAchievements() async -> FailureOr<[AchievementEntity]> { .right([]) }
    func fetchHabits() async -> FailureOr<[HabitEntity]> { .right([]) }
    func fetchSubscriptions() async -> FailureOr<[SubscriptionEntity]> { .right([]) }
}
