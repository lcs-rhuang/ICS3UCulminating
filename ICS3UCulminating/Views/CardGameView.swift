import SwiftUI

struct CardGameView: View {
    // MARK: - Stored properties
    var game = WarGame()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Card Wars")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                VStack {
                    Text("Player 1")
                        .font(.headline)
                    CardView(card: game.player1CurrentCard)
                    Text("Cards: \(game.player1Cards.count)")
                }
                
                Spacer()
                
                VStack {
                    Text("Player 2")
                        .font(.headline)
                    CardView(card: game.player2CurrentCard)
                    Text("Cards: \(game.player2Cards.count)")
                }
            }
            .padding()
            
            Text(game.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .frame(height: 100)
            
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

struct CardView: View {
    let card: Card?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 100, height: 150)
                .shadow(radius: 5)
            
            if let card = card {
                VStack {
                    Text(card.suit.rawValue)
                        .font(.largeTitle)
                    Text(card.rank.displayName)
                        .font(.title)
                        .fontWeight(.bold)
                }
            } else {
                // Card back
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
