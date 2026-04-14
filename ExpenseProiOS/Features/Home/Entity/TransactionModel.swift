import Foundation

// Supabase `transactions` jadvaliga mos keladigan DTO.
struct TransactionModel: Codable {
    let id: String
    let userId: String?
    let title: String
    let amount: Decimal
    let currency: String
    let kind: String
    let date: Date
    let category: String?
    let note: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case amount
        case currency
        case kind
        case date
        case category
        case note
    }

    func toEntity() -> TransactionEntity {
        TransactionEntity(
            id: id,
            title: title,
            amount: amount,
            currency: currency,
            kind: TransactionEntity.Kind(rawValue: kind) ?? .expense,
            date: date,
            category: category,
            note: note
        )
    }
}

struct TransactionInsertModel: Encodable {
    let userId: String
    let title: String
    let amount: Decimal
    let currency: String
    let kind: String
    let date: Date
    let category: String?
    let note: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case title, amount, currency, kind, date, category, note
    }
}
