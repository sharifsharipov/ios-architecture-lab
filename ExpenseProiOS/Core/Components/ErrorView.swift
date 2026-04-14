import SwiftUI

struct ErrorView: View {
    let message: String
    var onRetry: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundStyle(AppTheme.danger)
            Text(String(localized: "somethingWrong"))
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            if let onRetry {
                PrimaryButton(title: String(localized: "retry"), action: onRetry)
                    .fixedSize()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(AppTheme.Spacing.lg)
    }
}
