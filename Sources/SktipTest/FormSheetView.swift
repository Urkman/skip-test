import SkipFuseUI

struct FormSheetView<TitleContent: View, BodyContent: View, FooterContent: View>: View {
    @Environment(\.customDismiss) var customDismiss

    let title: TitleContent
    let bodyContent: BodyContent
    let footer: FooterContent

    init(
        @ViewBuilder title: () -> TitleContent,
        @ViewBuilder body: () -> BodyContent,
        @ViewBuilder footer: () -> FooterContent,
    ) {
        self.title = title()
        self.bodyContent = body()
        self.footer = footer()
    }

    var body: some View {
        Spacer()
        VStack(spacing: AppSpacing.Spacing.medium) {
            VStack(spacing: 0) {
                // Header
                title
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, AppSpacing.Padding.large)
                    .padding(.bottom, AppSpacing.Padding.large)

                // Body Content
                bodyContent
                    .padding(.bottom, AppSpacing.Padding.large)
            }
            .padding(.horizontal, AppSpacing.Padding.medium)
            .frame(maxWidth: .infinity)
            .background(Color.sheetBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppSpacing.CornerRadius.large, style: .continuous))
            .shadow(
                color: Color.shadow,
                radius: AppSpacing.Shadow.large.radius,
                x: 0,
                y: AppSpacing.Shadow.large.y
            )
            .overlay(
                Button {
                    customDismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: AppSpacing.IconSize.medium))
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, AppSpacing.Padding.large)
                .padding(.trailing, AppSpacing.Padding.medium),
                alignment: .topTrailing
            )

            // Footer Content
            footer
                .shadow(
                    color: Color.shadow,
                    radius: AppSpacing.Shadow.large.radius,
                    x: 0,
                    y: AppSpacing.Shadow.large.y
                )
        }
        .padding(.horizontal, AppSpacing.Padding.medium)
    }
}

// Convenience button style for the footer buttons
struct FormActionButton: View {
    let title: String
    let action: () -> Void
    let isLoading: Bool
    let isDisabled: Bool

    init(
        title: String,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(title)
                }
            }
            .font(.headline)
            .foregroundColor(isDisabled || isLoading ? Color.buttonTextInactive : Color.buttonText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.Padding.medium)
            .background(isDisabled || isLoading ? Color.buttonInactive : Color.buttonActive)
            .cornerRadius(AppSpacing.CornerRadius.medium)
        }
        .disabled(isDisabled || isLoading)
    }
}
