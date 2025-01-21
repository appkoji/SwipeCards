//
//  CardView.swift
//  SwipeCards
//
//  Created by 村田興児 on 2025/01/14.
//

import SwiftUI

struct CardView: View {
    
    //var inputText: String
    var inputWordCard: Word
    
    
    private let cardHeight = UIScreen.screenHeight * 0.6
    private let cardWidth = UIScreen.screenWidth * 0.8
    
    private let cardGrayColor = Color(uiColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)) //カードの背景色（スワイプ時に変色するため）
    
    @State private var offset = CGSize.zero //カードの初期の位置（真ん中）
    @State private var color: Color = Color(uiColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
    @State private var isFlipped: Bool = false //
    @State private var backcardOpacity = 1.0
    
    var body: some View {
        
        ZStack {
                        
            ZStack {
                
                // カードの下
                ZStack {
                    // カードの形をした長方形を生成
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .cornerRadius(45)
                        .foregroundStyle(.gray.opacity(backcardOpacity))
                }
                                
                // カードのウラを生成
                ZStack {
                    // カードの形をした長方形を生成
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .cornerRadius(45)
                        .foregroundStyle(color)
                        .shadow(radius: 10.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 45)
                                .stroke(.white, lineWidth: 5)
                        }
                    VStack {
                        // 生成されたカードの裏に、テキスト（答え）を載せる
                        Text(self.inputWordCard.answer)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .bold()
                            .frame(width: cardWidth-20)
                            
                    }
                }
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -90), axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .easeOut.delay(0.15) : .easeIn(duration:0.15), value: isFlipped)
                
                // カードのオモテ
                ZStack {
                    
                    // カードの形をした長方形を生成
                    Rectangle()
                        .frame(width: cardWidth, height: cardHeight)
                        .cornerRadius(45)
                        .foregroundStyle(color)
                        .shadow(radius: 10.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 45)
                                .stroke(.white, lineWidth: 5)
                        }
                    VStack {
                        // 生成されたカードの上に、テキスト（質問）を載せる
                        Text(self.inputWordCard.word)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .bold()
                            .frame(width: cardWidth-40)
                            .padding(100)
                    }
                }
                .rotation3DEffect( // 0~90度にカードを回すエフェクトを追加
                    .degrees(isFlipped ? 90 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                // カードを回す際のアニメーションを加える
                .animation(isFlipped ? .easeIn(duration: 0.15) : .easeOut.delay(0.15), value: isFlipped)
                
            }
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isFlipped.toggle()
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        backcardOpacity = 0.5
                        withAnimation {
                            self.chageColor(width: offset.width)
                        }
                    } .onEnded { _ in
                        withAnimation {
                            swipeCard(width: offset.width)
                            self.chageColor(width: offset.width)
                        }
                    }
            )
        }
        
        
    }
    

    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            backcardOpacity = 0.0
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            backcardOpacity = 0.0
        default:
            backcardOpacity = 1.0
            offset = .zero
        }
    }
    
    func chageColor(width: CGFloat) {
        print(width)
        switch width {
        case -500...(-130):
            color = .gray
        case 150...500:
            color = .gray
        default:
            color = cardGrayColor
        }
    }
    
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}



#Preview {
    CardView(inputWordCard: Word(word: "質問", answer: "答え"))
}
