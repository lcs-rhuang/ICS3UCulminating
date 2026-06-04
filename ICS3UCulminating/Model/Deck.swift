import Foundation

/// A model representing a deck of 52 playing cards.
struct Deck {
    // MARK: - Stored properties
    
    /// The collection of cards currently in the deck.
    var cards: [Card] = []
    
    // MARK: - Initializer
    
    /// Initializes a new deck with a full set of 52 cards.
    init() {
        self.cards = createFullDeck()
    }
    
    // MARK: - Functions
    
    /// Generates a standard 52-card deck by iterating through all suits and ranks.
    /// This follows the guidance to use explicit for-in loops for clarity.
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
    
    /// Randomizes the order of the cards in the deck.
    mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Removes and returns the top card from the deck, if one exists.
    mutating func draw() -> Card? {
        if cards.isEmpty {
            return nil
        }
        return cards.removeFirst()
    }
}
