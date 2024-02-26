import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            VStack {
                Spacer()
                Spacer()
                
                Image(.logoLarge)
                Text("Добро пожаловать в игру")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("КТО ХОЧЕТ СТАТЬ \n МИЛЛИОНЕРОМ")
                    .font(.title)
                    .foregroundStyle(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
                
                Spacer()
                VStack {
                    Button {
                        print("Правила игры")
                    } label: {
                        Text("Правила игры")
                            .padding(10)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 200)
                    .background(.purple)
                    .cornerRadius(10)
                    
                    
                    Button {
                        print("Играть")
                    } label: {
                        Text("Играть")
                            .padding(10)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 200)
                    .background(.purple)
                    .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    StartView()
}
