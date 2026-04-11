import SwiftUI

/// Renders simple algebraic formulas using styled Text.
/// Supports basic patterns: x², x³, superscripts, fractions displayed as a/b,
/// and common algebraic notation.
struct MathText: View {
    let text: String
    var font: Font = .AG.formula
    var color: Color = Color.AG.primaryText

    var body: some View {
        Text(parseFormula(text))
            .font(font)
            .foregroundColor(color)
            .accessibilityLabel(text)
    }

    private func parseFormula(_ input: String) -> AttributedString {
        var result = AttributedString()

        var i = input.startIndex
        while i < input.endIndex {
            let char = input[i]

            if char == "^" {
                // Handle superscript: ^2, ^3, ^n, ^{...}
                let nextIndex = input.index(after: i)
                if nextIndex < input.endIndex {
                    if input[nextIndex] == "{" {
                        // Multi-char superscript
                        if let closeBrace = input[nextIndex...].firstIndex(of: "}") {
                            let superText = String(input[input.index(after: nextIndex)..<closeBrace])
                            let mapped = mapToSuperscript(superText)
                            var attr = AttributedString(mapped)
                            attr.font = font
                            result.append(attr)
                            i = input.index(after: closeBrace)
                            continue
                        }
                    } else {
                        // Single char superscript
                        let superChar = String(input[nextIndex])
                        let mapped = mapToSuperscript(superChar)
                        var attr = AttributedString(mapped)
                        attr.font = font
                        result.append(attr)
                        i = input.index(nextIndex, offsetBy: 1, limitedBy: input.endIndex) ?? input.endIndex
                        continue
                    }
                }
            } else if char == "_" {
                // Handle subscript
                let nextIndex = input.index(after: i)
                if nextIndex < input.endIndex {
                    let subChar = String(input[nextIndex])
                    let mapped = mapToSubscript(subChar)
                    var attr = AttributedString(mapped)
                    attr.font = font
                    result.append(attr)
                    i = input.index(nextIndex, offsetBy: 1, limitedBy: input.endIndex) ?? input.endIndex
                    continue
                }
            }

            var attr = AttributedString(String(char))
            attr.font = font
            result.append(attr)
            i = input.index(after: i)
        }

        return result
    }

    private func mapToSuperscript(_ text: String) -> String {
        let superscripts: [Character: Character] = [
            "0": "\u{2070}", "1": "\u{00B9}", "2": "\u{00B2}", "3": "\u{00B3}",
            "4": "\u{2074}", "5": "\u{2075}", "6": "\u{2076}", "7": "\u{2077}",
            "8": "\u{2078}", "9": "\u{2079}", "+": "\u{207A}", "-": "\u{207B}",
            "n": "\u{207F}", "i": "\u{2071}"
        ]
        return String(text.map { superscripts[$0] ?? $0 })
    }

    private func mapToSubscript(_ text: String) -> String {
        let subscripts: [Character: Character] = [
            "0": "\u{2080}", "1": "\u{2081}", "2": "\u{2082}", "3": "\u{2083}",
            "4": "\u{2084}", "5": "\u{2085}", "6": "\u{2086}", "7": "\u{2087}",
            "8": "\u{2088}", "9": "\u{2089}"
        ]
        return String(text.map { subscripts[$0] ?? $0 })
    }
}
