import SwiftUI

extension Font {
    enum AG {
        static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
        static let title = Font.system(size: 24, weight: .bold, design: .default)
        static let subtitle = Font.system(size: 18, weight: .semibold, design: .default)
        static let body = Font.system(size: 16, weight: .regular, design: .default)
        static let bodyBold = Font.system(size: 16, weight: .semibold, design: .default)
        static let button = Font.system(size: 17, weight: .semibold, design: .default)
        static let caption = Font.system(size: 14, weight: .regular, design: .default)
        static let formula = Font.system(size: 18, weight: .medium, design: .monospaced)
        static let formulaLarge = Font.system(size: 22, weight: .medium, design: .monospaced)
        static let sartDigit = Font.system(size: 80, weight: .bold, design: .monospaced)
    }
}
