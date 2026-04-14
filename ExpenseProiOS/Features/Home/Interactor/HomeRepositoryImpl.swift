import Foundation
import Supabase

final class HomeRepositoryImpl: HomeRepository {
    private let supabase: SupabaseClient
    private let table = "transactions"
    private let recentLimit = 20

    init(provider: SupabaseProvider) {
        self.supabase = provider.client
    }

    func fetchSummary() async -> FailureOr<HomeSummary> {
        do {
            guard let userId = supabase.auth.currentUser?.id else {
                return .left(UnauthorizedFailure())
            }

            let rows: [TransactionModel] = try await supabase
                .from(table)
                .select()
                .eq("user_id", value: userId.uuidString)
                .order("date", ascending: false)
                .execute()
                .value

            var income: Decimal = 0
            var expense: Decimal = 0
            for row in rows {
                switch row.kind {
                case "income": income += row.amount
                case "expense": expense += row.amount
                default: break
                }
            }

            let recent = rows.prefix(recentLimit).map { $0.toEntity() }
            let currency = rows.first?.currency ?? "UZS"

            return .right(HomeSummary(
                balance: income - expense,
                income: income,
                expense: expense,
                currency: currency,
                recent: Array(recent)
            ))
        } catch {
            return .left(ServerFailure(message: error.localizedDescription))
        }
    }

    func fetchTransaction(id: String) async -> FailureOr<TransactionEntity> {
        do {
            let row: TransactionModel = try await supabase
                .from(table)
                .select()
                .eq("id", value: id)
                .single()
                .execute()
                .value
            return .right(row.toEntity())
        } catch {
            return .left(ServerFailure(message: error.localizedDescription))
        }
    }
}
