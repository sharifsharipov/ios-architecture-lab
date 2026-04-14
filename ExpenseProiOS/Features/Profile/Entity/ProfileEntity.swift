import Foundation

struct ProfileEntity: Equatable {
    let user: UserEntity
    let achievementsCount: Int
    let isPremium: Bool
}

struct AchievementEntity: Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let unlocked: Bool
    let iconName: String
}

struct HabitEntity: Identifiable, Equatable {
    let id: String
    let title: String
    let streak: Int
    let isActiveToday: Bool
}

struct SubscriptionEntity: Identifiable, Equatable {
    let id: String
    let name: String
    let price: Decimal
    let currency: String
    let period: String
    let nextRenewal: Date?
}
