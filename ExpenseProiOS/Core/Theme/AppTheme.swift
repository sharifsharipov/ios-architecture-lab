import SwiftUI

enum AppTheme {
    static let accent = Color(hex: 0x4F46E5)
    static let success = Color(hex: 0x10B981)
    static let warning = Color(hex: 0xF59E0B)
    static let danger = Color(hex: 0xEF4444)

    static let bgPrimary = Color("BgPrimary")
    static let bgSecondary = Color("BgSecondary")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")

    enum Corner {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
