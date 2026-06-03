import Foundation
import Observation

@Observable
class WarGame {
    // MARK: - Stored properties
    var player1Cards: [Card] = []
    var player2Cards: [Card] = []
    
    var player1CurrentCard: Card?
    var player2CurrentCard: Card?
    
    var cardsInPlay: [Card] = []
    var message: String = "Press 'Battle' to start!"
    var isGameOver: Bool = false
    var winnerName: String = ""
    
    // MARK: - Initializer
    init() {
        startNewGame()
    }
    
    // MARK: - Functions
    func startNewGame() {
        var deck: Deck = Deck()
        deck.shuffle()
        
        player1Cards = []
        player2Cards = []
        
        // Deal 26 cards to each player
        var counter: Int = 0
        for card in deck.cards {
            if counter % 2 == 0 {
                player1Cards.append(card)
            } else {
                player2Cards.append(card)
            }
            counter += 1
        }
        
        player1CurrentCard = nil
        player2CurrentCard = nil
        cardsInPlay = []
        message = "Deck shuffled and dealt. 26 cards each."
        isGameOver = false
        winnerName = ""
    }
    
    func playTurn() {
        if isGameOver { return }
        
        // Clear previous cards in play if we are starting a new round (not a war continuation)
        if cardsInPlay.isEmpty {
            player1CurrentCard = nil
            player2CurrentCard = nil
        }
        
        // Ensure both players have cards
        if player1Cards.isEmpty {
            endGame(winner: "Player 2")
            return
        }
        if player2Cards.isEmpty {
            endGame(winner: "Player 1")
            return
        }
        
        // Flip cards
        let p1Card: Card = player1Cards.removeFirst()
        let p2Card: Card = player2Cards.removeFirst()
        
        player1CurrentCard = p1Card
        player2CurrentCard = p2Card
        
        cardsInPlay.append(p1Card)
        cardsInPlay.append(p2Card)
        
        if p1Card.rank > p2Card.rank {
            message = "\(p1Card.description) beats \(p2Card.description)! Player 1 wins the round."
            resolveRound(winnerCards: &player1Cards)
        } else if p1Card.rank < p2Card.rank {
            message = "\(p2Card.description) beats \(p1Card.description)! Player 2 wins the round."
            resolveRound(winnerCards: &player2Cards)
        } else {
            message = "WAR! It's a tie at \(p1Card.rank.displayName)!"
            startWar()
        }
    }
    
    private func resolveRound(winnerCards: inout [Card]) {
        // Add all cards currently on the table to the winner's deck
        for card in cardsInPlay {
            winnerCards.append(card)
        }
        cardsInPlay = []
        
        checkWinCondition()
    }
    
    private func startWar() {
        // In a real game of War, each player puts 3 cards face down
        // We will simplify for the logic and just pull the cards if available
        
        for _ in 0..<3 {
            if !player1Cards.isEmpty {
                cardsInPlay.append(player1Cards.removeFirst())
            }
            if !player2Cards.isEmpty {
                cardsInPlay.append(player2Cards.removeFirst())
            }
        }
        
        // The next playTurn() call will handle the "War" tie-breaker
        // Note: In some versions, the war cards are flipped immediately. 
        // For simplicity, we just add them to the pile and wait for the next tap.
    }
    
    private func checkWinCondition() {
        if player1Cards.isEmpty {
            endGame(winner: "Player 2")
        } else if player2Cards.isEmpty {
            endGame(winner: "Player 1")
        }
    }
    
    private func endGame(winner: String) {
        isGameOver = true
        winnerName = winner
        message = "Game Over! \(winner) wins all the cards!"
    }
}
