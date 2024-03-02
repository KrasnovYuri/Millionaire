// Created by deovinsum

import SwiftUI

struct ScoreView: View {
    
    @AppStorage("TableScore") private var tableScore: [UserPoints] = []
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Image(.logoLarge)
                    .resizable()
                    .frame(width: 251, height: 259, alignment : .bottom)
                    .scaledToFit()
                Spacer()
                Text("Результаты игр")
                    .foregroundStyle(.white)
                    .font(.title)
                Form {
                    ForEach(tableScore) { record in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(record.user)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20))
                            }
                            Spacer()
                            Text(String(record.points))
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                        .listRowBackground(Color.clear)
                    }
                }
            }
        }
    }
    
    init(user: String, points: UInt16) {
        
        if tableScore.count == 10 {
            tableScore.removeFirst()
        }
        
        tableScore.append(UserPoints(user: user, points: points))
    }
    
}

//#Preview {
//    ScoreView(user: "User", points: 17)
//}
