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
    @State private var showingStats = false
    @State private var opacity = 0.0
    @ObservedObject private var viewModel = GameViewModel()
    let username: String
    
    var body: some View {
        if !viewModel.isLoser {
            MainGameView(viewModel: viewModel, didAnswer: { isRight in
                answerQuestion(isRight: isRight)
            })
            .disabled(viewModel.isWaiting)
            .opacity(opacity)
            .onAppear{
                viewModel.startNewGame()
                withAnimation(.easeInOut(duration: 2)) {
                    opacity = 1
                }
            }
        } else {
            ResultView(cash: viewModel.currentStat.price, isWin: false)
        }
        
        NavigationLink(destination: CurrentStats(), isActive: $showingStats) {
            CurrentStats()
        }.onChange(of: viewModel.sholdShowStatScreen) { newValue in
            showingStats = newValue
        }
    }
}

private extension GameView {
    func answerQuestion(isRight: Bool) {
        viewModel.answerQuestion(isRight: isRight)
    }
}
