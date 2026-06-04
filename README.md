# Card Wars (Classic War Game)

Card Wars is a digital implementation of the classic card game War, built using SwiftUI and the modern Swift Observation framework.

## How the Game Works

The objective is simple: Collect all 52 cards in the deck to win.

### Rules of Play

1. Dealing: The deck is shuffled and split evenly between two players (26 cards each).
2. The Battle: Both players flip their top card. The player with the higher card rank wins both cards and adds them to the bottom of their stack.
3. The Tie (War): If cards have the same rank, a War begins:
    - Each player places 3 cards face down.
    - Each player flips a 4th card face up to break the tie.
    - The winner of this new battle takes all cards currently on the table (the original tie, the 6 face-down cards, and the final face-up cards).
4. Winning: The game ends when one player runs out of cards.

---

## Example Game Session

Here is a step-by-step breakdown of how a typical game progresses:

### Step 1: Initialization
- You launch the app and see Card Wars.
- The game automatically shuffles a deck of 52 cards.
- Player 1 has 26 cards.
- Player 2 has 26 cards.
- Message says: Deck shuffled and dealt. 26 cards each.

### Step 2: First Battle
- You tap the Battle button.
- Player 1 flips: K (King)
- Player 2 flips: 7 (Seven)
- Result: King beats Seven!
- Outcome: Player 1 wins both cards. Player 1 now has 27 cards, Player 2 has 25.

### Step 3: A War Happens
- You tap Battle again.
- Player 1 flips: 10 (Ten)
- Player 2 flips: 10 (Ten)
- Result: It's a Tie! The message says WAR! It's a tie at 10!
- Behind the scenes: Both players move 3 cards from their deck to the table pile.

### Step 4: Resolving the War
- You tap Battle to break the tie.
- Player 1 flips: A (Ace)
- Player 2 flips: J (Jack)
- Result: Ace beats Jack!
- Outcome: Player 1 wins the entire pile (the 2 tens, the 6 face-down cards, and the Ace/Jack).
- Player 1's card count jumps significantly!

### Step 5: Game Over
- The game continues until Player 2 eventually loses all their cards.
- The button changes to New Game.
- Message says: Game Over! Player 1 wins all the cards!

---

## Code Structure

- Models:
    - Card.swift: Defines Suits and Ranks with comparison logic.
    - Deck.swift: Handles shuffling and dealing a standard 52-card deck.
- ViewModels:
    - WarGame.swift: The core engine. It manages the two players' decks and handles the rules for Battles and Wars.
- Views:
    - CardGameView.swift: The user interface, built with SwiftUI. It observes the WarGame state and updates the screen automatically.
