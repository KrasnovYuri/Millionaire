import SwiftUI

private struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
            }
            content
                .foregroundColor(.black)
        }
    }
}

struct LoginView: View {
    @State private var isStartGame = false
    @State private var nickname = ""
    @State private var animationAmount = 0.0

    var body: some View {
            ZStack {
                GradientBackgroundView()
                
                VStack {
                    Image(.logoLarge)
                        .rotation3DEffect(
                            .degrees(animationAmount),
                            axis: (x: 1, y: 0, z: 0))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 2)) {
                                    animationAmount += 360
                                }
                            }
                        }
                    
                    Text("🔐 Регистрация")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    TextField("", text: $nickname)
                        .modifier(PlaceholderStyle(showPlaceHolder: nickname.isEmpty, placeholder: "Введите свой никнейм"))
                        .padding(10)
                        .foregroundColor(.black)
                        .background(.accent)
                        .cornerRadius(10)
                        .padding(.vertical)
                        .keyboardType(.default)
                        .submitLabel(.done)
                    
                    Button {
                        isStartGame = true
                    } label: {
                        DestinationView(title: "Начать игру")
                    }.disabled(nickname.isEmpty)
                    .fullScreenCover(isPresented: $isStartGame) {
                        GameView(username: nickname)
                    }
                    
                    Spacer()
                }
                .onSubmit {
                    print("Начать игру")
                }
                .padding()
            }
        }
}
