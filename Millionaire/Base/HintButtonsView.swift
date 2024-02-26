//
//  HintButtonsView.swift
//  Millionaire
//
//  Created by Максим Самороковский on 26.02.2024.
//

import SwiftUI

// MARK - Buttons hints
struct HintButtonsView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Image("helpIcon1")
                    .renderingMode(.original)
            }
            Button(action: {}) {
                Image("helpIcon2")
                    .renderingMode(.original)
            }
            
            TimerView()
            
            Button(action: {}) {
                Image("helpIcon3")
                    .renderingMode(.original)
            }
            Button(action: {}) {
                Image("helpIcon4")
                    .renderingMode(.original)
            }
        }
        .padding(.top, 20)
    }
}

struct TimerView: View {
    var body: some View {
        VStack {
            Image("timer")
                .renderingMode(.original)
                .foregroundColor(.white)
                .font(.system(size: 12))
        }
    }
}
