import SwiftUI
import Questions

struct GameView: View {
    @ObservedObject private var viewModel = GameViewModel()
    let username: String
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Image(.logoLarge)
                    .resizable()
                    .frame(width: 153, height: 158)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .colorMultiply(Color.gray.opacity(0.8))
                
                HintButtonsView()
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
                        var labels = ["A: ", "B: ", "C: ", "D: "]
                        
                        ForEach(Array(zip(answers.indices, answers)), id: \.0) { index, item in
                            VStack(spacing: 18) {
                                AnswerButtonView(label: labels[index], text: item.title, action: {
                                    answerQuestion(isRight: item.isRight)
                                })
                            }
                        }
                    }
            }
        }.onAppear{
            viewModel.startNewGame()
        }
    }
}

private extension GameView {
    func answerQuestion(isRight: Bool) {
        viewModel.newQuestion()
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(username: "sdaDas")
    }
}

