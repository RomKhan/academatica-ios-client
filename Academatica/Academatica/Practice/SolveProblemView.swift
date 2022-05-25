//
//  SolveProblemView.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import SwiftUI

struct SolveProblemView: View {
    @StateObject var viewModel: SolveProblemViewModel
    @Binding var state: ProblemState
    @Binding var selected: [String]
    
    var body: some View {
        VStack(spacing: 25) {
            Text(viewModel.model.text)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            
            
            HStack {
                TextField("", text: $selected[0])
                    .placeholder(when: selected[0].isEmpty) {
                        Text("Введите ответ здесь")
                            .opacity(0.8)
                            .selfSizeMask(
                                Rectangle().fill(.black)
                            )
                            .blendMode(.overlay)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: UIScreen.main.bounds.height / 50))
                if (state == .correctAnswer) {
                    Rectangle()
                        .fill(.white)
                        .mask(
                            Image("successSelectedMark")
                                .resizable()
                                .scaledToFit()
                        )
                        .frame(width: UIScreen.main.bounds.height / 45, height: UIScreen.main.bounds.height / 45)
                        .blendMode(.overlay)
                } else if (state == .incorrectAnswer) {
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
            .padding(15)
            .padding(.horizontal, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(state == .waiting ? VisualEffectView(effect: UIBlurEffect(style: .light)) : nil)
            .background(
                state == .correctAnswer ?
                ColorService.ProblemStateColor.goodAnswer.getGradient() :
                    state == .incorrectAnswer ?
                ColorService.ProblemStateColor.badAnswer.getGradient() :
                    ColorService.ProblemStateColor.none.getGradient()
            )
            .cornerRadius(UIScreen.main.bounds.height / 35)
            .shadow(
                color:
                    state == .correctAnswer ?
                ColorService.ProblemStateColor.goodAnswer.getShadowColor() :
                    state == .incorrectAnswer ?
                ColorService.ProblemStateColor.badAnswer.getShadowColor() :
                    ColorService.ProblemStateColor.none.getShadowColor(),
                radius: 15,
                x: 0, y: 0)
        }
        .disabled(state != .waiting)
    }
}


struct SolveProblemView_Previews: PreviewProvider {
    static var previews: some View {
        SolveProblemView(viewModel: SolveProblemViewModel(model: SolveProblemModel(text: "dgfgdfgfdgdfgdbfg fgnyrtg erfewcefbgfbvcvdfv fddgfdsxsacd fgnyrtger fewcefbgfbvcvdfvf ddgfdsxsacd fgnyrtgerfewc efbgfbvcvdf vfddgfdsxsacd", correctAnswer: ["1"])), state: .constant(.correctAnswer), selected: .constant([]))
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
