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
                gradient: Gradient(colors: [Color(hex: 0x184925), Color(hex: 0x19332A)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
}

struct CurrentStats: View {
    @State private var fiftyFiftyButtonPressed = false
    @State private var helpAudienceButtonPressed = false
    @State private var callFriendButtonPressed = false
    @State private var buttonPressed = false
    
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
                        QuestionRow(questionNumber: 15, cost: 1000000, colorType: .fireproofAmountColor)
                        QuestionRow(questionNumber: 14, cost: 500000, colorType: .standardColor)
                        QuestionRow(questionNumber: 13, cost: 250000, colorType: .standardColor)
                        QuestionRow(questionNumber: 12, cost: 125000, colorType: .standardColor)
                        QuestionRow(questionNumber: 11, cost: 64000, colorType: .standardColor)
                        QuestionRow(questionNumber: 10, cost: 32000, colorType: .fireproofAmountColor)
                        QuestionRow(questionNumber: 9, cost: 16000, colorType: .standardColor)
                        QuestionRow(questionNumber: 8, cost: 8000, colorType: .standardColor)
                        QuestionRow(questionNumber: 7, cost: 4000, colorType: .standardColor)
                        QuestionRow(questionNumber: 6, cost: 2000, colorType: .standardColor)
                        QuestionRow(questionNumber: 5, cost: 1000, colorType: .fireproofAmountColor)
                        QuestionRow(questionNumber: 4, cost: 500, colorType: .standardColor)
                        QuestionRow(questionNumber: 3, cost: 300, colorType: .standardColor)
                        QuestionRow(questionNumber: 2, cost: 200, colorType: .standardColor)
                        QuestionRow(questionNumber: 1, cost: 100, colorType: .standardColor)
                    }
                    .padding()
                }
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
