import Foundation

struct GoalEntity: Identifiable, Equatable {
    let id: String
    let title: String
    let targetAmount: Decimal
    let savedAmount: Decimal
    let currency: String
    let deadline: Date?

    var progress: Double {
        guard targetAmount > 0 else { return 0 }
        return min(1.0, NSDecimalNumber(decimal: savedAmount).doubleValue /
                       NSDecimalNumber(decimal: targetAmount).doubleValue)
    }
}
