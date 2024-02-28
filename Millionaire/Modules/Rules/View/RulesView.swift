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
                    Text("Задача организации, в особенности же консультация с широким активом обеспечивает широкому кругу (специалистов) участие в формировании модели развития. Равным образом укрепление и развитие структуры позволяет оценить значение форм развития. Значимость этих проблем настолько очевидна, что реализация намеченных плановых заданий способствует подготовки и реализации форм развития. С другой стороны начало повседневной работы по формированию позиции в значительной степени обуславливает создание системы обучения кадров, соответствует насущным потребностям.")
                         
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 15)
                        .lineSpacing(7)

                        .frame(height: 507)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
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

