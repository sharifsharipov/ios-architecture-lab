import Foundation
import Supabase

// Flutter `supabase_flutter` ning iOS ekvivalenti.
// URL va anon key'ni `AppConfig` dan oladi.

final class SupabaseProvider {
    let client: SupabaseClient

    init(config: AppConfig) {
        self.client = SupabaseClient(
            supabaseURL: URL(string: config.supabaseURL)!,
            supabaseKey: config.supabaseAnonKey
        )
    }
}

struct AppConfig {
    let supabaseURL: String
    let supabaseAnonKey: String

    static let `default` = AppConfig(
        supabaseURL: ProcessInfo.processInfo.environment["SUPABASE_URL"] ?? "https://YOUR_PROJECT.supabase.co",
        supabaseAnonKey: ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"] ?? "YOUR_ANON_KEY"
    )
}
