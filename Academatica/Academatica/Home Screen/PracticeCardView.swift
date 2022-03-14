//
//  PracticeCard.swift
//  SmartMath
//
//  Created by Roman on 08.01.2022.
//

import SwiftUI

struct PracticeCardView: View {
    @StateObject var viewModel: PracticeCardViewModel
    var body: some View {
        ZStack {
            HStack() {
                Rectangle().frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .mask {
                        Image(viewModel.model.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding(.leading, 25)
                            .padding(.trailing, 10)
                    }
                    .blendMode(.overlay)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.model.title).font(.system(size: 18, weight: .heavy)).foregroundColor(.white)
                    Text("\(viewModel.model.countOfTasks) задач").font(.system(size: 12, weight: .semibold)).textCase(.uppercase).foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            }.frame(height: 100, alignment: .leading)
            
            LinearGradient(stops: [
                .init(color: viewModel.colors[1], location: 0.4),
                .init(color: viewModel.colors[0], location: 0.7)
            ], startPoint: .topTrailing, endPoint: .bottomLeading)
                .frame(maxWidth: .infinity)
                .frame(height: 600)
                .mask {
                    Rectangle()
                        .frame(height: 100)
                        .cornerRadius(25)
                }
                .zIndex(-1)
                .shadow(color: viewModel.colors[2], radius: 30, x: 0, y: 0)
        }.frame(maxWidth: .infinity).frame(height: 100)
    }
}

struct PracticeCard_Previews: PreviewProvider {
    static var previews: some View {
        PracticeCardView(
            viewModel: PracticeCardViewModel(model: PracticeCardModel(title: "Completed Topics", countOfTasks: 10, imageName: "tick-inside-circle"),
                                             colors: [
                                                Color(uiColor: UIColor(
                                                    red: 239 / 255.0,
                                                    green: 147 / 255.0,
                                                    blue: 126 / 255.0,
                                                    alpha: 1)),
                                                Color(uiColor: UIColor(
                                                    red: 170 / 255.0,
                                                    green: 30 / 255.0,
                                                    blue: 245 / 255.0,
                                                    alpha: 1)),
                                                Color(uiColor: UIColor(
                                                    red: 206 / 255.0,
                                                    green: 92 / 255.0,
                                                    blue: 182 / 255.0,
                                                    alpha: 1))
                                             ])).padding(.horizontal, 20)
    }
}
