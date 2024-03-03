import SwiftUI

struct RulesView: View {
    var body: some View {
        ZStack {
            GradientBackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                Image("logoLarge")
                    .resizable()
                    .frame(width: 153, height: 158)
                    .scaledToFit()
                
                Text("Правила игры")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ScrollView {
                    Text("Игрок отвечает на серию вопросов с вариантами ответов. За каждый правильный ответ игрок получает определенное количество очков или денежный выигрыш. Игрок может использовать различные подсказки, такие как \"50/50\" (удаление двух неправильных вариантов ответов), \"помощь зала\" (просьба к зрителям о своем мнении) и \"звонок другу\" (звонок другу за помощью). Если игрок дает неправильный ответ, он может потерять все свои очки или денежный выигрыш, если таковые имеются. Цель игры - набрать максимальное количество очков или денежный выигрыш, включая выигрыш за последний правильный ответ.")
                         
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 15)
                        .lineSpacing(7)

                        .frame(height: 507)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(LinearGradient(colors: [Color(hex: 0x14144C), Color(hex: 0x2D1158)], startPoint: .leading, endPoint: .trailing))
                        )
                        .padding([.horizontal, .top], 16)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}

