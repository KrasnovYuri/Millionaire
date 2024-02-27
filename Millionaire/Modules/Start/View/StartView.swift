import SwiftUI

struct StartView: View {
    @State private var isShowingLoginView = false
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            VStack {
                Spacer()
                
                Image(.logoLarge)
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                    .onAppear {
                        withAnimation {
                            animationAmount += 360
                        }
                    }
                    
                Spacer()
                
                Text("Добро пожаловать в игру")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("КТО ХОЧЕТ СТАТЬ \n МИЛЛИОНЕРОМ")
                    .font(.title)
                    .foregroundStyle(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
                
                Spacer()
                
                VStack {
                    ReusableButton(name: "Правила игры") {
                        print("Правила игры")
                    }
                    
                    ReusableButton(name: "Играть") {
                        isShowingLoginView = true
                    }
                    .fullScreenCover(isPresented: $isShowingLoginView) {
                        LoginView()
                    }
                    
                }
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    StartView()
}
