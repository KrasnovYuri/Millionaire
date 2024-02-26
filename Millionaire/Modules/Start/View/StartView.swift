import SwiftUI
import Questions

struct StartView: View {
    let quest: QuestionStorageProtocol = QuestionStorage()
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Image(.logoLarge)
            Text("Добро пожаловать в игру")
                .font(.title)
            
            Spacer()
            
            Text("КТО ХОЧЕТ СТАТЬ \n МИЛЛИОНЕРОМ")
                .font(.title)
            
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
            
//            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    StartView()
}
