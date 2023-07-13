//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Devin King on 7/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var isWrongAnswerAlertShowing = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var countries = ["Estonia", "France" , "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tappedFlagIndex = 0 
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                   
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the Flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your Score is \(userScore)")
            }
            .alert(scoreTitle, isPresented: $isWrongAnswerAlertShowing) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("You picked the flag for \(countries[tappedFlagIndex])")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedFlagIndex = number // Store the tapped flag index
        if number == correctAnswer {
            scoreTitle = "Correct✅"
            userScore += 1
            showingScore = true
        } else {
            scoreTitle = "Wrong😔"
            isWrongAnswerAlertShowing = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

