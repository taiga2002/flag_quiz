//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 北尾　大河 on 2021/10/11.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany","Ireland", "Italy","Nigeria","Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:30) {
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) {
                    number in Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
            Spacer()
            
            }
            VStack(spacing: 40){
                Text("Current Score \(currentScore)")
                    .offset(y:200)
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score \(currentScore)"), dismissButton: .default(Text("Continue")) {
                self.askQUestion()
            })
        }
    }
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else{
            scoreTitle = "Wrong. That's the flag of \(self.countries[number])"
        }
        showingScore = true
    }
    func askQUestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
