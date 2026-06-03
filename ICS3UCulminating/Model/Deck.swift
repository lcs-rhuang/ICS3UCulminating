import Foundation

struct Deck {
    // MARK: - Stored properties
    var cards: [Card] = []
    
    // MARK: - Initializer
    init() {
        self.cards = createFullDeck()
    }
    
    // MARK: - Functions
    func createFullDeck() -> [Card] {
        var newDeck: [Card] = []
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let card: Card = Card(suit: suit, rank: rank)
                newDeck.append(card)
            }
        }
        return newDeck
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func draw() -> Card? {
        if cards.isEmpty {
            return nil
        }
        return cards.removeFirst()
    }
}
