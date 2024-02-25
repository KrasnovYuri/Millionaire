import SwiftUI
import Questions

struct StartView: View {
    let quest: QuestionStorageProtocol = QuestionStorage()
    var body: some View {
        Button("Test") {
            quest.fetchAllQuestions { questions in
                print(questions)
            }
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
