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
        .background(Color(red: 41/255, green: 17/255, blue: 86/255))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}

