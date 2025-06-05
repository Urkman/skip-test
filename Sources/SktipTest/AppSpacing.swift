import SkipFuseUI

/// A namespace containing standardized spacing, padding, and corner radius values for UI elements
enum AppSpacing {
    // MARK: - Padding values
    
    /// Standard padding values for UI elements
    enum Padding {
        /// Small padding (8 points)
        static let small: CGFloat = 8
        
        /// Medium padding (16 points)
        static let medium: CGFloat = 16
        
        /// Large padding (24 points)
        static let large: CGFloat = 24
        
        /// Extra large padding (32 points)
        static let extraLarge: CGFloat = 32
        
        /// Content padding for list items and small containers (12 points)
        static let content: CGFloat = 12
        
        /// Horizontal padding for screen edges (16 points)
        static let horizontal: CGFloat = 16
        
        /// Vertical padding for sections (20 points)
        static let vertical: CGFloat = 20
    }
    
    // MARK: - Spacing values
    
    /// Standard spacing values for UI elements
    enum Spacing {
        /// Extra small spacing (4 points)
        static let extraSmall: CGFloat = 4
        
        /// Small spacing (8 points)
        static let small: CGFloat = 8
        
        /// Medium spacing (12 points)
        static let medium: CGFloat = 12
        
        /// Large spacing (16 points)
        static let large: CGFloat = 16
        
        /// Extra large spacing (24 points)
        static let extraLarge: CGFloat = 24
        
        /// Spacing between sections (32 points)
        static let section: CGFloat = 32
    }
    
    // MARK: - Corner radius values
    
    /// Standard corner radius values for UI elements
    enum CornerRadius {
        /// Small corner radius (4 points)
        static let small: CGFloat = 4
        
        /// Medium corner radius (8 points)
        static let medium: CGFloat = 8
        
        /// Large corner radius (16 points)
        static let large: CGFloat = 16
        
        /// Extra large corner radius (24 points)
        static let extraLarge: CGFloat = 24
        
        /// Full circle/pill corner radius (uses .infinity)
        static let pill: CGFloat = .infinity
    }
    
    // MARK: - Icon sizes
    
    /// Standard icon sizes for UI elements
    enum IconSize {
        /// Small icon size (16 points)
        static let small: CGFloat = 16
        
        /// Medium icon size (24 points)
        static let medium: CGFloat = 24
        
        /// Large icon size (32 points)
        static let large: CGFloat = 32
    }
    
    // MARK: - Shadow values
    
    /// Standard shadow values for UI elements
    enum Shadow {
        /// Small shadow (radius: 2, y-offset: 1)
        static let small: (radius: CGFloat, y: CGFloat) = (2, 1)

        /// Medium shadow (radius: 4, y-offset: 2)
        static let medium: (radius: CGFloat, y: CGFloat) = (4, 2)
        
        /// Large shadow (radius: 10, y-offset: 4)
        static let large: (radius: CGFloat, y: CGFloat) = (10, 4)
    }
}
