//
//  ContentView.swift
//  SwipeCards
//
//  Created by 村田興児 on 2025/01/14.
//

import SwiftUI

struct Word: Identifiable {
    var id = UUID()
    var word: String
    var answer: String
}

struct ContentView: View {
    
    var words = [
            Word(word: "りんご", answer: "Apple"),
            Word(word: "ナシ", answer: "Pear"),
            Word(word: "ザクロ", answer: "Pomegranate"),
            
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
            ForEach(words) { aCard in
                CardView(inputWordCard: aCard)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
