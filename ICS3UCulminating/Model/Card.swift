import Foundation

/// Represents the four suits in a standard deck of cards.
enum Suit: String, CaseIterable {
    case hearts = "❤️"
    case diamonds = "♦️"
    case clubs = "♣️"
    case spades = "♠️"
}

/// Represents the rank of a card, from two to ace.
/// Conforms to Comparable so we can easily determine which card is "bigger".
enum Rank: Int, CaseIterable, Comparable {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
    
    /// Returns a short string representation of the rank (e.g., "A", "K", "10").
    var displayName: String {
        switch self {
        case .ace: return "A"
        case .king: return "K"
        case .queen: return "Q"
        case .jack: return "J"
        default: return "\(self.rawValue)"
        }
    }
    
    /// Standard comparison logic: Higher rawValue means a higher rank.
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

/// A model representing a single playing card.
struct Card: Identifiable, Equatable {
    let id = UUID() // Unique identifier for SwiftUI lists and loops
    let suit: Suit
    let rank: Rank
    
    /// Provides a human-readable description like "A❤️" or "10♠️".
    var description: String {
        return "\(rank.displayName)\(suit.rawValue)"
    }
}
