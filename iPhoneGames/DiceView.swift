//
//  ContentView.swift
//  Dice
//
//  Created by Ross Drew on 27/07/2022.
//

import SwiftUI


// MARK: Dice Tutorial https://www.ralfebert.com/ios-app-development/swiftui-tutorial/
// MARK: Extensive XCode overview (@10): https://www.youtube.com/watch?v=F2ojC6TNwws
 
struct DiceView: View {
    @State private var diceNumber = Int.random(in: 1...6)
    
    private var rollReportMessage: String {
        "A \(diceNumber) was rolled"
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("Roxofts Dice")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Image("dice-\(diceNumber)")
            
            Spacer()
                        
            Button {
                diceNumber = Int.random(in: 1...6)
            } label: {
             //   Image(systemName: "hand.raised.fill")
                Image("diceroll")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, alignment: .center)
            }
            
            
            Spacer()
            
            Text(rollReportMessage)
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .italic()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
