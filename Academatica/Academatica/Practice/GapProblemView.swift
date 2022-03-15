//
//  GapProblemView.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import SwiftUI

struct GapProblemView: View {
    @StateObject var viewModel: GapProblemViewModel
    @Binding var state: ProblemState
    @Binding var selected: [String]
    
    var body: some View {
        VStack {
            ForEach((0..<viewModel.rows.count), id: \.self) { i in
                HStack {
                    ForEach((0..<viewModel.rows[i].count), id: \.self) { j in
                        if (viewModel.answersIndexes.firstIndex(of: j) == nil) {
                            Text(viewModel.rows[i][j])
                                .font(.system(size: UIScreen.main.bounds.width / 12.5, weight: .bold))
                                .foregroundColor(.white)
                        }
                        else {
                            TextField("", text: $selected[viewModel.answersIndexes.firstIndex(of: j)!])
                                .foregroundColor(.white)
                                .font(.system(size: UIScreen.main.bounds.width / 18))
                                .padding(7)
                                .padding(.horizontal, 5)
                                .frame(width:
                                        min(max( CGFloat(selected[viewModel.answersIndexes.firstIndex(of: j)!].count) * UIScreen.main.bounds.width / 31 + 30, 55), UIScreen.main.bounds.width / 3), alignment: .leading)
                                .background(state == .waiting ? VisualEffectView(effect: UIBlurEffect(style: .light)) : nil)
                                .background(
                                    state == .correctAnswer || viewModel.model.correctAnswer.contains(selected[viewModel.answersIndexes.firstIndex(of: j)!]) && state != .waiting ?
                                    ColorService.ProblemStateColor.goodAnswer.getGradient() :
                                        state == .incorrectAnswer  ?
                                    ColorService.ProblemStateColor.badAnswer.getGradient() :
                                        ColorService.ProblemStateColor.none.getGradient()
                                )
                                .cornerRadius(UIScreen.main.bounds.height / 70)
                                .shadow(
                                    color:
                                        state == .correctAnswer || viewModel.model.correctAnswer.contains(selected[viewModel.answersIndexes.firstIndex(of: j)!]) && state != .waiting ?
                                        ColorService.ProblemStateColor.goodAnswer.getShadowColor() :
                                            state == .incorrectAnswer  ?
                                        ColorService.ProblemStateColor.badAnswer.getShadowColor() :
                                            ColorService.ProblemStateColor.none.getShadowColor(),
                                    radius: 15,
                                    x: 0, y: 0)
                        }
                    }
                }
            }
        }
        .disabled(state != .waiting)
    }
}

struct GapProblemView_Previews: PreviewProvider {
    static var previews: some View {
        GapProblemView(viewModel: GapProblemViewModel(model: GapProblemModel(expression: "123 +_GAP_= 21 +_GAP_= 2_GAP_", correctAnswer: ["1", "1", "1"])), state: .constant(.waiting), selected: .constant(["", "", ""]))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 59 / 255.0, blue: 149 / 255.0, alpha: 1)), location: 0),
                            .init(color: Color(uiColor: UIColor(red: 132 / 255.0, green: 163 / 255.0, blue: 185 / 255.0, alpha: 1)), location: 1.1)
                        ]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading)
            )
    }
}
