//
//  LeadBoardCard.swift
//  SmartMath
//
//  Created by Roman on 16.01.2022.
//

import SwiftUI

struct LeadBoardCardView: View {
    @StateObject var viewModel: LeadBoardCardViewModel
    var cardHeight = UIScreen.main.bounds.height
    var body: some View {
        VStack(spacing: 0) {
            if (UserStateService.shared.userLeaderboardState != nil && UserStateService.shared.userLeaderboardState!.league != .none) {
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("\(viewModel.leagueName) лига")
                            .font(.system(size: cardHeight / 45, weight: .heavy))
                            .transition(.opacity)
                            .animation(.spring(), value: viewModel.leagueName)
                        Spacer()
                        Text(viewModel.message ?? "")
                            .font(.system(size: cardHeight / 62))
                            .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                            .transition(.opacity)
                            .animation(.spring(), value: viewModel.message)
                        
                    }
                    .padding(.vertical, 20)
                    Spacer()
                    Image(viewModel.imageName ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(height: cardHeight / 7)
                        .blendMode(.overlay)
                        .transition(.opacity)
                        .animation(.spring(), value: viewModel.imageName)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                Text("")
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
                    .background(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                    .padding(.horizontal, 20)
                Text(viewModel.timeNow)
                    .font(.system(size: cardHeight / 62))
                    .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                    .padding(.vertical, 10)
            }
        }
        .transition(.opacity)
        .animation(.spring(), value: UserStateService.shared.userLeaderboardState?.league)
        .frame(maxWidth: .infinity)
        .frame(height: cardHeight / 5)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .onAppear {
            viewModel.viewUpdate()
        }
    }
}

struct LeadBoardCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LeadBoardCardView(viewModel: LeadBoardCardViewModel())
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
