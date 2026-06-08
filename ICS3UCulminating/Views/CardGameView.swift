import SwiftUI

/// The main view for the Card Wars game, displaying the cards and controls.
struct CardGameView: View {
    // MARK: - Stored properties
    
    /// The ViewModel instance that drives the game logic.
    /// We use a local property as it doesn't need to be shared globally yet.
    @State var game = WarGame()
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            // Header title
            Text("Card Wars")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Display for both players
            HStack {
                // Player 1 Side
                VStack {
                    Text("Player 1")
                        .font(.headline)
                    CardView(card: game.player1CurrentCard)
                    Text("Cards: \(game.player1Cards.count)")
                }
                
                Spacer()
                
                // Player 2 Side
                VStack {
                    Text("Player 2")
                        .font(.headline)
                    CardView(card: game.player2CurrentCard)
                    Text("Cards: \(game.player2Cards.count)")
                }
            }
            .padding()
            
            // Status Message Area
            Text(game.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .frame(height: 100)
            
            // Control Button (Switches between Battle and New Game)
            if game.isGameOver {
                Button(action: {
                    game.startNewGame()
                }) {
                    Text("New Game")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    game.playTurn()
                }) {
                    Text("Battle!")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

/// A helper view to render a single card or a card back.
struct CardView: View {
    /// The card to display. If nil, shows the card back.
    let card: Card?
    
    var body: some View {
        ZStack {
            // Card base
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 100, height: 150)
                .shadow(radius: 5)
            
            // Content (Rank and Suit) or Card Back
            if let card = card {
                VStack {
                    Text(card.suit.rawValue)
                        .font(.largeTitle)
                    Text(card.rank.displayName)
                        .font(.title)
                        .fontWeight(.bold)
                }
            } else {
                // Card back design
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.8))
                    .padding(5)
            }
        }
    }
}

#Preview {
    CardGameView()
}
