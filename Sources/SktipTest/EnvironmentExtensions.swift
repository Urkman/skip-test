import SkipFuseUI

struct CustomDismissActionKey: @preconcurrency EnvironmentKey {
    @MainActor static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var customDismiss: () -> Void {
        get { self[CustomDismissActionKey.self] }
        set { self[CustomDismissActionKey.self] = newValue }
    }
}
