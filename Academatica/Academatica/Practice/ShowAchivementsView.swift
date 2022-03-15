//
//  ShowAchivementsView.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import SwiftUI

struct ShowAchivementsView: View {
    @StateObject var viewModel: ShowAchivementsViewModel
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Получены достижения".uppercased())
                    .foregroundColor(.white)
                    .font(.system(size: UIScreen.main.bounds.height / 35))
                    .padding(.top, UIScreen.main.bounds.height / 25)
            }
            .padding(.top, UIScreen.main.bounds.height / 20)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.achivements) { model in
                    AchievementCardView(viewModel: AchievementCardViewModel(model: model))
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 100)
                .padding(.vertical, 20)
            }
            .padding(.top, 10)
            
            
            Button {
                viewModel.exitFunc()
            } label: {
                Text("Продолжить".uppercased())
                    .foregroundColor(.white)
                    .font(.system(size: UIScreen.main.bounds.height / 55, weight: .bold))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: UIColor(red: 0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)))
            .cornerRadius(UIScreen.main.bounds.height / 60)
            .shadow(color: Color(uiColor: UIColor(red: 0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 40)
            .padding()
            .padding(.bottom, UIScreen.main.bounds.height / 25)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .frame(alignment: .bottom)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct ShowAchivementsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAchivementsView(viewModel: ShowAchivementsViewModel(achivements: [
            AchievementModel(
                name: "Get started",
                description: "Completed first lesson (and some text)",
                imageUrl: URL(fileURLWithPath: "shuttle"),
                achievedAmount: 2
            ),
            AchievementModel(
                name: "Get started",
                description: "Completed first lesson (and some text for the second line)",
                imageUrl: URL(fileURLWithPath: "shuttle"),
                achievedAmount: 20
            ),
            AchievementModel(
                name: "Get started hehehhe",
                description: "Completed first lesson (and some text for the second line)",
                imageUrl: URL(fileURLWithPath: "shuttle"),
                achievedAmount: 2
            ),
            AchievementModel(
                name: "Get started",
                description: "Completed first lesson (and some text for the second line)",
                imageUrl: URL(fileURLWithPath: "shuttle"),
                achievedAmount: 2
            )
        ], exit: {}))
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
