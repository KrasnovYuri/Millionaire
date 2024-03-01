//
//  CurrentStats.swift
//  Millionaire
//
//  Created by Юрий on 27.02.2024.
//

import SwiftUI

struct QuestionRow: View {
    var questionNumber: Int
    var cost: Int
    var colorType: RowColors
    
    var body: some View {
        let color = getLinearGradient()
        HStack {
            Text("Вопрос \(questionNumber)")
            Spacer()
            Text("\(cost) ₽")
        }
        .padding(7)
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10).fill(color))
    }

    enum RowColors {
        case standardColor
        case fireproofAmountColor
        case answerColor
    }

    func getLinearGradient() -> LinearGradient {
        switch colorType {
        case .standardColor:
            return LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x111149), Color(hex: 0x2F1357)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        case .fireproofAmountColor:
            return LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x151A64), Color(hex: 0x3F1271)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        case .answerColor:
            return LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x089D2F), Color(hex: 0x19332A)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
}

struct CurrentStats: View {
    @State var fiftyFiftyButtonPressed = false
    @State var helpAudienceButtonPressed = false
    @State var callFriendButtonPressed = false
    @State var buttonPressed = false
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            VStack {
                HStack(spacing: 20) {
                    if fiftyFiftyButtonPressed {
                        Image(.BG)
                    } else {
                        Image(.helpIcon1)
                    }
                    
                    if helpAudienceButtonPressed {
                        Image(.BG)
                    } else {
                        Image(.helpIcon2)
                    }
                    
                    Image(.logoLarge)
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    if callFriendButtonPressed {
                        Image(.BG)
                    } else {
                        Image(.helpIcon3)
                    }
                    
                    if buttonPressed {
                        Image(.BG)
                    } else {
                        Image(.helpIcon4)
                    }
                }
                
                ScrollView {
                    LazyVStack(spacing: 7) {
                        ForEach(StatQuestion.allCases.reversed(), id: \.price) { stat in
                            QuestionRow(questionNumber: stat.rawValue, cost: Int(stat.price), colorType: stat.isFireproof ? .fireproofAmountColor : .standardColor)
                        }
                    }
                }
                .padding()
                
                HStack(spacing: 180){
                    Button(action: {
                        
                    }) {
                        Text("Забрать деньги")
                            .underline()
                    }
                    .foregroundColor(.white)
                    
                    Button(action: {
                        
                    }) {
                        Text("Далее")
                            .underline()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    CurrentStats()
}
