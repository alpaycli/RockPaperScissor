//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alpay Calalli on 07.07.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var choices = ["🪨", "📄", "✂️"]
    @State private var winnerChoices = ["📄", "✂️", "🪨"]
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var questions = 0
    
    @State private var endAlert = false

    
    var body: some View {
        VStack {
            Spacer()
            Text(shouldWin ? "Win":"Lose")
                .font(.largeTitle.weight(.bold))
            Text("against")
                .font(.title)
            Text("\(choices[appChoice])")
                .font(.system(size: 40))
            
            Section{
                HStack{
                    ForEach(0..<3){number in
                        Button{
                            moveTapped(number)
                        }label: {
                            Text(choices[number])
                                .font(.system(size: 60))
                        }
                    }
                }
                Text(scoreTitle)
                
            Spacer()
            Text("Score : \(score)")
        }
    }
        .alert(Text("Game over"),isPresented: $endAlert){
            Button("Cancel", role: .cancel){}
            Button("Restart", action: reset)
        }
}
        func moveTapped(_ number: Int){
            if choices[appChoice] == winnerChoices[number]{
                shouldWin ? incorrect() : correct()
            }else{
                shouldWin ? correct() : incorrect()
            }
            nextTurn()
        }
        
        func nextTurn(){
            appChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questions += 1
            
            if questions == 10{
                endAlert = true
            }
        }
        
        func correct(){
            scoreTitle = "Correct"
            score += 1
        }
        
        func incorrect(){
            scoreTitle = "Wrong"
            score -= 1
        }
    
    func reset() -> Void{
        score = 0
        questions = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
