import SwiftUI

// iOS 17 `ContentUnavailableView` ning iOS 16 uchun muqobili.
struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let subtitle: String?

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: systemImage)
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text(title).font(.title3.bold())
            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppTheme.Spacing.xxl)
    }
}
