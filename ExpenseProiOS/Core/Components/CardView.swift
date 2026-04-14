import SwiftUI

struct CardView<Content: View>: View {
    var background: Color = AppTheme.bgSecondary
    var padding: CGFloat = AppTheme.Spacing.lg
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(background, in: RoundedRectangle(cornerRadius: AppTheme.Corner.lg))
    }
}

struct SectionHeader: View {
    let title: String
    var action: (() -> Void)? = nil
    var actionTitle: String? = nil

    var body: some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
            if let action, let actionTitle {
                Button(actionTitle, action: action)
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.accent)
            }
        }
    }
}
