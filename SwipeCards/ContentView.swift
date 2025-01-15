//
//  ContentView.swift
//  SwipeCards
//
//  Created by 村田興児 on 2025/01/14.
//

import SwiftUI

struct WordCard: Identifiable {
    var id = UUID()
    var word: String
    var answer: String
}

struct ContentView: View {
    
    var wordCards: [WordCard] = [
            WordCard(word: "ちしき", answer: "Knowledge"),
            WordCard(word: "やま", answer: "Mountain"),
            WordCard(word: "まなぶ", answer: "Learn"),
            WordCard(word: "ことば", answer: "Word"),
            WordCard(word: "かお", answer: "Face"),
            WordCard(word: "さいふ", answer: "Wallet"),
    ].reversed()
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack{
                Text("おしまい")
                    .font(.title)
                    .foregroundStyle(.black)
                    .bold()
            }
            ForEach(wordCards) { aCard in
                CardView(inputWordCard: aCard)
            }
        }
    }
}

#Preview {
    ContentView()
}
