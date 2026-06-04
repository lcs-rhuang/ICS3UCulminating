import Foundation
import Observation

/// The ViewModel that manages the logic and state for a game of Card Wars (War).
/// Marked with @Observable to allow SwiftUI views to react to property changes.
@Observable
class WarGame {
    // MARK: - Stored properties
    
    /// Player 1's current stack of face-down cards.
    var player1Cards: [Card] = []
    
    /// Player 2's current stack of face-down cards.
    var player2Cards: [Card] = []
    
    /// The card Player 1 just flipped over.
    var player1CurrentCard: Card?
    
    /// The card Player 2 just flipped over.
    var player2CurrentCard: Card?
    
    /// A temporary pile of cards that are currently being fought over (includes ties/wars).
    var cardsInPlay: [Card] = []
    
    /// The status message displayed to the user.
    var message: String = "Press 'Battle' to start!"
    
    /// Flag indicating if the game has concluded.
    var isGameOver: Bool = false
    
    /// The name of the winner, set when the game ends.
    var winnerName: String = ""
    
    // MARK: - Initializer
    
    /// Sets up a fresh game upon initialization.
    init() {
        startNewGame()
    }
    
    // MARK: - Functions
    
    /// Prepares a new game by shuffling a deck and dealing cards to both players.
    func startNewGame() {
        var deck: Deck = Deck()
        deck.shuffle()
        
        player1Cards = []
        player2Cards = []
        
        // Deal the cards. We use a counter and a loop to explicitly divide the deck.
        var counter: Int = 0
        for card in deck.cards {
            if counter % 2 == 0 {
                player1Cards.append(card)
            } else {
                player2Cards.append(card)
            }
            counter += 1
        }
        
        // Reset the table state
        player1CurrentCard = nil
        player2CurrentCard = nil
        cardsInPlay = []
        message = "Deck shuffled and dealt. 26 cards each."
        isGameOver = false
        winnerName = ""
    }
    
    /// Executes a single turn (a "battle").
    func playTurn() {
        // Prevent action if the game is already over
        if isGameOver { return }
        
        // Clear the visual of previous cards if we aren't in the middle of a tie-breaker (War)
        if cardsInPlay.isEmpty {
            player1CurrentCard = nil
            player2CurrentCard = nil
        }
        
        // Check if either player is out of cards before starting the turn
        if player1Cards.isEmpty {
            endGame(winner: "Player 2")
            return
        }
        if player2Cards.isEmpty {
            endGame(winner: "Player 1")
            return
        }
        
        // Each player pulls the top card from their deck
        let p1Card: Card = player1Cards.removeFirst()
        let p2Card: Card = player2Cards.removeFirst()
        
        // Update the current cards for the UI to display
        player1CurrentCard = p1Card
        player2CurrentCard = p2Card
        
        // Add the flipped cards to the pile on the table
        cardsInPlay.append(p1Card)
        cardsInPlay.append(p2Card)
        
        // Compare ranks to determine the winner
        if p1Card.rank > p2Card.rank {
            message = "\(p1Card.description) beats \(p2Card.description)! Player 1 wins the round."
            resolveRound(winnerCards: &player1Cards)
        } else if p1Card.rank < p2Card.rank {
            message = "\(p2Card.description) beats \(p1Card.description)! Player 2 wins the round."
            resolveRound(winnerCards: &player2Cards)
        } else {
            // Ranks are equal: A Tie leads to a War!
            message = "WAR! It's a tie at \(p1Card.rank.displayName)!"
            startWar()
        }
    }
    
    /// Gives all cards currently on the table to the winner.
    private func resolveRound(winnerCards: inout [Card]) {
        for card in cardsInPlay {
            winnerCards.append(card)
        }
        // Clear the table for the next round
        cardsInPlay = []
        
        // Check if the game should end
        checkWinCondition()
    }
    
    /// Handles the "War" scenario where three cards are placed face down.
    private func startWar() {
        // According to rules: place 3 cards face down
        for _ in 0..<3 {
            if !player1Cards.isEmpty {
                cardsInPlay.append(player1Cards.removeFirst())
            }
            if !player2Cards.isEmpty {
                cardsInPlay.append(player2Cards.removeFirst())
            }
        }
        
        // The next tap on the 'Battle' button will draw the 4th card to break the tie.
    }
    
    /// Checks if a player has run out of cards.
    private func checkWinCondition() {
        if player1Cards.isEmpty {
            endGame(winner: "Player 2")
        } else if player2Cards.isEmpty {
            endGame(winner: "Player 1")
        }
    }
    
    /// Sets the game state to 'Game Over' and announces the winner.
    private func endGame(winner: String) {
        isGameOver = true
        winnerName = winner
        message = "Game Over! \(winner) wins all the cards!"
    }
}
