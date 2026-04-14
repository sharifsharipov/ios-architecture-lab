import Foundation

protocol ProfileRepository {
    func fetchProfile() async -> FailureOr<ProfileEntity>
    func fetchAchievements() async -> FailureOr<[AchievementEntity]>
    func fetchHabits() async -> FailureOr<[HabitEntity]>
    func fetchSubscriptions() async -> FailureOr<[SubscriptionEntity]>
}
