import SwiftUI
import SoundManager
import Questions

//Максим
//Сделать задержку после ответа и моргание кнопки ответа на неск сек + заменить музыку
//После "проверки" подсветить кнопку красным/зеленым и перейти на экран статистики подсветим ответ
//Спустя несколько секунд вернуться назад и продолжить игру
//Логику подсказок реализовать
//Анимация кнопок при ответе (влево, вправо) пример видео в дискорд

struct GameView: View {
    @State private var opacity = 0.0
    @ObservedObject private var viewModel = GameViewModel()
    let username: String
    
    var body: some View {
        if !viewModel.isLoser {
            
            ZStack {
                GradientBackgroundView()
                VStack {
                    Image(.logoLarge)
                        .resizable()
                        .frame(width: 153, height: 158)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .colorMultiply(Color.gray.opacity(0.8))
                    
                    HintButtonsView(viewModel: viewModel)
                        .padding(.top, 20)
                    
                    HStack {
                        Text("Вопрос \(viewModel.currentStat.rawValue)")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .semibold))
                        Spacer()
                        HStack {
                            Image(.cash)
                            Text("\(viewModel.currentStat.price) ₽")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .semibold))
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    QuestionView(title: viewModel.currentQuestion?.title ?? "")
                        .padding(.top, 16)
                        .padding(.bottom, 10)
                    
                    if let answers = viewModel.currentQuestion?.answers {
                        let labels = ["A: ", "B: ", "C: ", "D: "]
                        
                        ForEach(Array(zip(answers.indices, answers)), id: \.0) { index, item in
                            VStack(spacing: 18) {
                                AnswerButtonView(label: labels[index], text: item.title, action: {
                                    answerQuestion(isRight: item.isRight)
                                })
                            }
                        }
                    }
                }.opacity(opacity)
            }.onAppear{
                viewModel.startNewGame()
                SoundManager.shared.play(.startGame)
                withAnimation(.easeInOut(duration: 4)) {
                    opacity = 1
                }
            }
        } else {
            ResultView(cash: viewModel.currentStat.price, isWin: false)
        }
    }
}

private extension GameView {
    func answerQuestion(isRight: Bool) {
        viewModel.answerQuestion(isRight: isRight)
    }
}
