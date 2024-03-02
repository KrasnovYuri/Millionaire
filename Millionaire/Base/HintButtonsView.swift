import SwiftUI

struct HintButtonsView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            createButtons(range: 0..<2)
            
            Spacer()
            
            Text("⏱️ \(viewModel.currentTime)")
                .foregroundStyle(viewModel.currentTime < 10 ? .red : .white)
                .font(.system(size: 28, weight: .semibold))
                .border(.green)
            
            Spacer()
            
            createButtons(range: 2..<4)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 10)
    }
}

private extension HintButtonsView {
    func createButtons(range: CountableRange<Int>) -> some View {
        ForEach(range, id: \.self) { index in
            if let helper = viewModel.enabledHelers[safe: index], helper.isEnable {
                Button {
                    viewModel.tapHelp(helper)
                } label: {
                    Image(helper.type.imageName)
                        .renderingMode(.original)
                }
            } else {
                Button { } label: {
                    Image("helpIconEmpty")
                        .renderingMode(.original)
                }
            }
        }
    }
}
