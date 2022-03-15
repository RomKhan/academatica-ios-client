//
//  LoadLeadBoards.swift
//  Academatica
//
//  Created by Roman on 13.03.2022.
//

import SwiftUI

struct LoadLeadBoardsView: View {
    @StateObject var viewModel = LoadLeadBoardsViewModel()
    @State private var heightOfset: CGFloat = 0
    var body: some View {
        ZStack {
            if viewModel.serverState == .success, let state = UserStateService.shared.userLeaderboardState, state.league != .none {
                LeadBoardsView()
            } else if (viewModel.serverState == .success && (viewModel.league == nil || viewModel.league! == .none)) {
                LottieView(name: "work", loopMode: .loop)
                    .padding(UIScreen.main.bounds.height / 13)
                    .offset(y: -UIScreen.main.bounds.height / 7)
                VStack {
                    Text("Похоже, что вы не состоите в лиге!")
                    Text("Завершайте уроки, чтобы попасть в таблицу лидеров")
                }
                .offset(y: UIScreen.main.bounds.height / 15)
        }
        
        ZStack {
            LoadingView(serverState: $viewModel.serverState, errorMessage: .constant("Не вышло загрузить таблицу лидеров"))
                .offset(y: -heightOfset)
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                if viewModel.serverState == .error {
                    Button {
                        withAnimation {
                            viewModel.tryLoadLeaderboardState()
                        }
                    } label: {
                        Text("Попробовать еще раз")
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(.white)
                            .shadow(color: .white.opacity(0.5), radius: 3, x: 0, y: 0)
                    }
                    .padding()
                    .background(.red)
                    .cornerRadius(15)
                    .shadow(color: .red.opacity(0.5), radius: 15, x: 0, y: 0)
                    .offset(y: UIScreen.main.bounds.height / 1.4)
                }
            }
        }
        .offset(y: -UIScreen.main.bounds.height / 8)
        .background(.white)
        .opacity(viewModel.serverState == .success ? 0 : 1)
        .animation(.easeIn(duration: 0.2), value: viewModel.serverState)
    }
}
}

struct LoadLeadBoards_Previews: PreviewProvider {
    static var previews: some View {
        LoadLeadBoardsView()
    }
}
