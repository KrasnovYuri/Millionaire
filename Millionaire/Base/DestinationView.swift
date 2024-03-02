//
//  ReusableButton.swift
//  Millionaire
//
//  Created by Юрий on 27.02.2024.
//

import SwiftUI

struct DestinationView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .padding(10)
            .foregroundColor(Color.white)
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

