import Foundation

enum Suit: String, CaseIterable {
    case hearts = "❤️"
    case diamonds = "♦️"
    case clubs = "♣️"
    case spades = "♠️"
}

enum Rank: Int, CaseIterable, Comparable {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
    
    var displayName: String {
        switch self {
        case .ace: return "A"
        case .king: return "K"
        case .queen: return "Q"
        case .jack: return "J"
        default: return "\(self.rawValue)"
        }
    }
    
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

struct Card: Identifiable, Equatable {
    let id = UUID()
    let suit: Suit
    let rank: Rank
    
    var description: String {
        return "\(rank.displayName)\(suit.rawValue)"
    }
}
