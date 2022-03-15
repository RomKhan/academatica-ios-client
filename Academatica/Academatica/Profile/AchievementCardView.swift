//
//  AchievemntCardView.swift
//  SmartMath
//
//  Created by Roman on 15.01.2022.
//

import SwiftUI

struct AchievementCardView: View {
    @StateObject var viewModel: AchievementCardViewModel
    var multiplicator = UIScreen.main.bounds.width / 2 - 30
    var body: some View {
            ZStack(alignment: .topTrailing) {
                    ZStack {
                        Text(viewModel.model.achievedAmount < 99 ? "\(viewModel.model.achievedAmount)" : "99+")
                            .foregroundColor(.white)
                            .font(.system(
                                size: viewModel.model.achievedAmount < 10 ?  multiplicator / 8 : viewModel.model.achievedAmount < 99 ?  multiplicator / 10 : multiplicator / 12, weight: .bold)
                            )
                    }
                .zIndex(2)
                .frame(width: multiplicator / 5, height: multiplicator / 5)
                .background(viewModel.colors[3])
                .background(.ultraThinMaterial)
                .cornerRadius(100)
                .padding(.trailing, -multiplicator / 15)
                .padding(.top, -multiplicator / 20)
                    
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .fill(.white)
                        .mask {
                            AsyncImage(
                                url: viewModel.model.imageUrl,
                                transaction: Transaction(animation: .spring()))
                            { phase in
                                switch phase {
                                case .empty:
                                    Rectangle().fill(.white)
                                        .blendMode(.overlay)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .transition(.scale(scale: 0.1, anchor: .center))
                                case .failure:
                                    Image(systemName: "wifi.slash")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        .frame(height: multiplicator / 2.1)
                        .frame(maxWidth: .infinity)
                        .padding(.top, multiplicator / 8)
                        .padding(.bottom, multiplicator / 10)
                        .blendMode(.overlay)
                    Text(viewModel.model.name)
                        .font(.system(size: multiplicator / 8.5, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(.horizontal, multiplicator / 15)
                    Text(viewModel.model.description)
                        .font(.system(size: multiplicator / 13))
                        .foregroundColor(.white)
                        .padding(.horizontal, multiplicator / 15)
                        .padding(.top, multiplicator / 50)
                        .padding(.bottom, multiplicator / 18)
                    
                }
                .frame(maxWidth: multiplicator)
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            stops: [
                                .init(color: viewModel.colors[0], location: -0.2),
                                .init(color: viewModel.colors[1], location: 1.2)
                            ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
                .cornerRadius(multiplicator / 8)
                .shadow(color: viewModel.colors[2], radius: 15, x: 0, y: 0)
            }
    }
}

struct AchievemntCardView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCardView(
            viewModel: AchievementCardViewModel(model: AchievementModel(name: "Get started", description: "Completed first lesson (and some text for the second line)", imageUrl: URL(fileURLWithPath: "shuttle"), achievedAmount: 2))
        )
            .padding(40)
    }
}
