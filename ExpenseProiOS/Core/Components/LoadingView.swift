import SwiftUI

struct LoadingView: View {
    var title: String? = nil

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            ProgressView().scaleEffect(1.2)
            if let title {
                Text(title).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct InlineLoader: View {
    var body: some View {
        HStack { ProgressView(); Spacer() }
            .padding(.vertical, AppTheme.Spacing.md)
    }
}
