//
//  ProblemWithImageView.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import SwiftUI

struct ProblemWithImageView: View {
    @StateObject var viewModel: ProblemWithImageViewModel
    @Binding var state: ProblemState
    @Binding var selected: [String]
    var body: some View {
        VStack(spacing: 25) {
            AsyncImage(
                url: viewModel.model.imageUrl,
                transaction: Transaction(animation: .spring()))
            { phase in
                switch phase {
                case .empty:
                    Rectangle().fill(.white)
                        .frame(height: UIScreen.main.bounds.width / 2)
                        .blendMode(.overlay)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Rectangle().fill(.white)
                        .frame(height: UIScreen.main.bounds.width / 1.4)
                        .blendMode(.overlay)
                        .overlay(
                            Image(systemName: "wifi.slash")
                                .resizable()
                                .scaledToFit()
                                .blendMode(.overlay)
                                .padding(UIScreen.main.bounds.width / 4)
                        )
                    
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(25)
            .frame(maxWidth: UIScreen.main.bounds.width)
            
            
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

struct ProblemWithImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemWithImageView(viewModel: ProblemWithImageViewModel(model: ProblemWithImageModel(imageUrl: URL(string: "https://cdn2.vectorstock.com/i/1000x1000/40/71/definition-of-geometry-vector-22954071.jpg")!, correctAnswer: ["1"])), state: .constant(.correctAnswer), selected: .constant([]))
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
