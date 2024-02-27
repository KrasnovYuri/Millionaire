//
//  HintButtonsView.swift
//  Millionaire
//
//  Created by Максим Самороковский on 26.02.2024.
//

import SwiftUI

// MARK - Buttons hints
struct HintButtonsView: View {
    @State private var showIcon1 = true
    @State private var showIcon2 = true
    @State private var showIcon3 = true
    @State private var showIcon4 = true

    var body: some View {
        HStack {
            Button(action: {
                self.showIcon1.toggle()
            }) {
                if showIcon1 {
                    Image("helpIcon1")
                        .renderingMode(.original)
                } else {
                    Image("helpIconEmpty")
                        .renderingMode(.original)
                }
            }

            Button(action: {
                self.showIcon2.toggle()
            }) {
                if showIcon2 {
                    Image("helpIcon2")
                        .renderingMode(.original)
                } else {
                    Image("helpIconEmpty")
                        .renderingMode(.original)
                }
            }

            Spacer()
            TimerView()
            Spacer()

            Button(action: {
                self.showIcon3.toggle()
            }) {
                if showIcon3 {
                    Image("helpIcon3")
                        .renderingMode(.original)
                } else {
                    Image("helpIconEmpty")
                        .renderingMode(.original)
                }
            }

            Button(action: {
                self.showIcon4.toggle()
            }) {
                if showIcon4 {
                    Image("helpIcon4")
                        .renderingMode(.original)
                } else {
                    Image("helpIconEmpty")
                        .renderingMode(.original)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 10)
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

