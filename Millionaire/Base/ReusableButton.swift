//
//  ReusableButton.swift
//  Millionaire
//
//  Created by Юрий on 27.02.2024.
//

import SwiftUI

struct ReusableButton: View {
    var name: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(name)
                .padding(10)
                .foregroundColor(Color.white)
        }
        .frame(width: 200)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(hex: 0x14144C), Color(hex: 0x2D1158)]),
            startPoint: .leading,
            endPoint: .trailing
        ))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: 0x4F02B5), lineWidth: 3)
        )
    }
}

