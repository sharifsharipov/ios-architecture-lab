import Foundation

struct FinanceRecordEntity: Identifiable, Equatable {
    let id: String
    let title: String
    let amount: Decimal
    let currency: String
    let date: Date
    let category: String?
}
