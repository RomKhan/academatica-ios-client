//
//  ChoiceView.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import SwiftUI

struct ChoiceView: View {
    var multichoice: Bool
    @StateObject var viewModel: ChoiceViewModel
    @Binding var state: ProblemState
    @Binding var selected: [String]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.model.options, id: \.self) { option in
                HStack {
                    Text(option)
                        .foregroundColor(.white)
                        .font(.system(size: UIScreen.main.bounds.height / 50))
                    Spacer()
                    if (selected.contains(option) &&
                        state == .waiting) {
                        Rectangle()
                            .fill(.white)
                            .mask(
                                Image("selectedMark")
                                    .resizable()
                                    .scaledToFit()
                            )
                            .frame(width: UIScreen.main.bounds.height / 45, height: UIScreen.main.bounds.height / 45)
                    } else if (viewModel.model.correctAnswers.contains(option) && state != .waiting) {
                        Rectangle()
                            .fill(.white)
                            .mask(
                                Image("successSelectedMark")
                                    .resizable()
                                    .scaledToFit()
                            )
                            .frame(width: UIScreen.main.bounds.height / 45, height: UIScreen.main.bounds.height / 45)
                            .blendMode(.overlay)
                    } else if (selected.contains(option) && state != .waiting) {
                        Rectangle()
                            .fill(.white)
                            .mask(
                                Image("mistakeSelectedMark")
                                    .resizable()
                                    .scaledToFit()
                            )
                            .frame(width: UIScreen.main.bounds.height / 45, height: UIScreen.main.bounds.height / 45)
                            .blendMode(.overlay)
                    }
                }
                .padding(12)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(!viewModel.model.correctAnswers.contains(option) && !selected.contains(option) || state == .waiting ? VisualEffectView(effect: UIBlurEffect(style: .light)) : nil)
                .background(
                    viewModel.model.correctAnswers.contains(option) && selected.contains(option) && state != .waiting ?
                    ColorService.ProblemStateColor.goodAnswer.getGradient() :
                        selected.contains(option) && state != .waiting ?
                    ColorService.ProblemStateColor.badAnswer.getGradient() :
                        viewModel.model.correctAnswers.contains(option) && !selected.contains(option) && state != .waiting ?
                    ColorService.ProblemStateColor.unmarkedAnswer.getGradient() :
                        ColorService.ProblemStateColor.none.getGradient()
                )
                .cornerRadius(UIScreen.main.bounds.height / 35)
                .shadow(
                    color:                     viewModel.model.correctAnswers.contains(option) && selected.contains(option) && state != .waiting ?
                        ColorService.ProblemStateColor.goodAnswer.getShadowColor() :
                            selected.contains(option) && state != .waiting ?
                        ColorService.ProblemStateColor.badAnswer.getShadowColor() :
                            viewModel.model.correctAnswers.contains(option) && !selected.contains(option) && state != .waiting ?
                        ColorService.ProblemStateColor.unmarkedAnswer.getShadowColor() :
                            ColorService.ProblemStateColor.none.getShadowColor(),
                    radius: 15, x: 0, y: 0)
                .onTapGesture {
                    if !multichoice {
                        selected.removeAll()
                    }
                    if let index = selected.firstIndex(of: option) {
                        selected.remove(at: index)
                    } else {
                        selected.append(option)
                    }
                }
            }
            .disabled(state != .waiting)
        }
    }
}

struct ChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceView(multichoice: true, viewModel: ChoiceViewModel(model: ChoiceModel(options: ["1", "2", "3", "4"], correctAnswers: ["1", "3"])), state: .constant(.incorrectAnswer), selected: .constant([]))
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
