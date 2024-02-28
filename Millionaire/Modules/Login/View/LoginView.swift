import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
            }
            content
            .foregroundColor(Color.white)
//            .padding(5.0)
        }
    }
}

struct LoginView: View {
    @State private var nickname = ""

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ZStack {
            GradientBackgroundView()

            VStack {
                Image(.logoLarge)

                Text("🔐 Регистрация")
                    .font(.title)
                    .foregroundColor(.white)

                TextField("", text: $nickname)
                .modifier(PlaceholderStyle(showPlaceHolder: nickname.isEmpty, placeholder: "Введите свой никнейм"))
                    .padding(10)
                    .foregroundColor(.gray)
                    .background(.accent)
                    .cornerRadius(10)
                    .padding(.vertical)
                    .keyboardType(.default)
                    .submitLabel(.done)

                Button {
                    print("Начать игру")
                } label: {
                    Text("Начать игру")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
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

//#Preview {
//    LoginView()
//}
