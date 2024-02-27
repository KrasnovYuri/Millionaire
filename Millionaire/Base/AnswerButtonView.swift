//
//  AnswerButtonView.swift
//  Millionaire
//
//  Created by Максим Самороковский on 26.02.2024.
//

import SwiftUI

// MARK: - Buttons for qustions
struct AnswerButtonView: View {
    let label: String
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                Spacer()
                Text(text)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                Spacer()
            }
            .font(.system(size: 22, weight: .regular))
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(LinearGradient(colors: [.indigo, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
        }
    }
}
