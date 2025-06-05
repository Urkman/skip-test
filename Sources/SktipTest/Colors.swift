import Foundation
import SkipFuseUI

extension Color {
    // MARK: - Background colors
    static let background = Color("Background", bundle: .module)
    static let sheetBackground = Color("SheetBackground", bundle: .module)
    static let tileBackground = Color("TileBackground", bundle: .module)
    static let formBackground = Color("Form", bundle: .module)

    // MARK: - Text colors
    static let text = Color("TextColor", bundle: .module)
    static let secondaryText = Color("SecondaryTextColor", bundle: .module)

    // MARK: - Accent and interaction colors
    static let accent = Color("AccentColor", bundle: .module)
    static let shadow = Color("Shadow", bundle: .module)

    // MARK: - Button states
    static let buttonActive = Color("ButtonActive", bundle: .module)
    static let buttonInactive = Color("ButtonInactive", bundle: .module)

    // MARK: - Button text colors
    static let buttonText = Color("ButtonTextColor", bundle: .module)
    static let buttonTextInactive = Color("ButtonTextInactiveColor", bundle: .module)
    static let accentButtonText = Color("AccentButtonTextColor", bundle: .module)
    static let deleteButtonText = Color("DeleteButtonTextColor", bundle: .module)
    static let acceptButtonText = Color("AcceptButtonTextColor", bundle: .module)

    // MARK: - Accept/Delete buttons
    static let acceptButtonActive = Color("AcceptButtonActive", bundle: .module)
    static let acceptButtonInactive = Color("AcceptButtonInactive", bundle: .module)
    static let deleteButtonActive = Color("DeleteButtonActive", bundle: .module)
    static let deleteButtonInactive = Color("DeleteButtonInactive", bundle: .module)

    // MARK: - Status colors
    static let success = Color("Success", bundle: .module)
    static let info = Color("Info", bundle: .module)
    static let warning = Color("Warning", bundle: .module)
    static let error = Color("Error", bundle: .module)

    // MARK: - Additional utility colors
    static let separator = Color("Separator", bundle: .module)
    static let navigationBar = Color("NavigationBar", bundle: .module)
}
