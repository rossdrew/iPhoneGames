//
//  ContentView.swift
//  Cards
//
//  Created by Ross Drew on 27/07/2022.
//

import SwiftUI

class Card: CustomStringConvertible{
    enum Suit: CaseIterable {
        case hearts
        case diamonds
        case clubs
        case spades
    }
    
    enum Rank: CaseIterable {
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
        case ace
        
        var numerical : String {
          switch self {
          case .two: return "2"
          case .three: return "3"
          case .four: return "4"
          case .five: return "5"
          case .six: return "6"
          case .seven: return "7"
          case .eight: return "8"
          case .nine: return "9"
          case .ten: return "10"
          case .jack: return "jack"
          case .queen: return "queen"
          case .king: return "king"
          case .ace: return "ace"
          }
        }
    }
    
    var rank: Rank
    var suit: Suit
    
    init(rank: Rank, suit: Suit)
    {
        self.rank = rank
        self.suit = suit
    }

    public var description: String {
        return "\(rank) of \(suit)"
    }
    
    public var numericalDescription: String {
        return "\(rank.numerical)_of_\(suit)"
    }
}

class Deck {
    private var liveDeck: [Card]
    internal var dealt: [Card]
    private var burners: [Card]
    
    init() {
        liveDeck = []
        dealt = []
        burners = []
        newDeck()
    }
    
    /**
     Create a new, ordered deck
     */
    private func newDeck() {
        for suit in Card.Suit.allCases {
            for rank in Card.Rank.allCases {
                liveDeck.append(Card(rank: rank, suit: suit))
            }
        }
    }
    
    /**
     Randomly shuffle the deck
     */
    func shuffle(){
        liveDeck.shuffle()
    }
    
    /**
     Draw a card, record it as dealt and return it
     */
    func deal() -> Card? {
        guard let drawnCard = liveDeck.popLast() else {
            print("No cards left in deck!")
            return nil
        }
        
        dealt.append(drawnCard)
        return drawnCard
    }
    
    /**
     Draw a card and move to the burn pile
     */
    func burn() {
        guard let drawnCard = liveDeck.popLast() else {
            print("No cards left in deck!")
            return
        }
        
        burners.append(drawnCard)
    }
}

/**
 A deck which keeps track of it's running count
 */
class CountedDeck: Deck {
    private var count = 0
    
    override init(){
        super.init()
    }
    
    private func count(card: Card) -> Int {
        switch(card.rank){
            case .two, .three, .four, .five, .six: return 1
            case .seven, .eight, .nine: return 0
            case .ten, .jack, .queen, .king, .ace: return -1
        }
    }
    
    /**
     Draw a card, record it as dealt, count  and return it
     */
    override func deal() -> Card? {
        guard let drawnCard = super.deal() else {
            print("No cards left in deck!")
            return nil
        }
        
        count+=count(card: drawnCard)
        return drawnCard
    }
    
    func runningCount() -> Int {
        return count
    }
}

struct CardView: View {
    @State private var deckOfCards = CountedDeck()
    @State private var dealtCard: Card?
    @State private var shownCard: String = "back"

    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("Roxofts Cards")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Text("\(deckOfCards.runningCount())")
            
            HStack(alignment: .center){
                Button {
                    deckOfCards = CountedDeck()
                    shownCard = "back@x2"
                } label: {
                    Image(systemName: "hands.sparkles")
                }
                
                Button {
                    deckOfCards.shuffle()
                } label: {
                    Image(systemName: "shuffle")
                }
                
                Button {
                    dealtCard = deckOfCards.deal()
                    if dealtCard == nil {
                        shownCard = "black_joker"
                    }
                } label: {
                    Image(systemName: "hand.raised.fill")
                }
            }
            
            Spacer()
            
            Image("\(dealtCard?.numericalDescription ?? shownCard)").border(Color.black, width: 2)
            Text("\(dealtCard?.description ?? "No Cards Remain")")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .italic()
            
            Spacer()
        }
    }
}

struct ContentView_Cards: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
