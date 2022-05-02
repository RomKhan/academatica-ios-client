//
//  ContentView.swift
//  Academatica
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI
import ResizableSheet

struct TabBar: View {
    @State var selected: ScreenType = .home
    @State var showTopic: Bool = false
    @State var showClass: Bool = false
    @State var showCompletedPracticeSheet: Bool = true
    @State var showSettings: CGFloat = UIScreen.main.bounds.width
    @Namespace var namespace
    @ObservedObject var viewModel = TabBarViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Group {
                    switch selected {
                    case .home:
                        HomeView(showClass: $showClass, selected: $selected)
                    case .lesson:
                        TierView(viewModel: TierViewModel(), show: $showTopic, namespace: namespace)
                            .navigationBarHidden(true)
                    case .profile:
                        ProfileView()
                    case .leadboard:
                        if (UserStateService.shared.userLeaderboardState?.league == nil || UserStateService.shared.userLeaderboardState!.league == .none) {
                            LoadLeadBoardsView().navigationBarHidden(true)
                        } else {
                            LeadBoardsView().navigationBarHidden(true)
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if (showTopic) {
                    TopicView(show: $showTopic, namespace: namespace)
                        .zIndex(3)
                }
                
                if (showClass) {
                    LessonView(viewModel: LessonViewModel(
                        topicName: CourseService.shared.currentClass?.topicName ?? ""),
                            showSheet: $showClass)
                        .offset(y: showClass ? 0 : UIScreen.main.bounds.height * 1.5)
                        .animation(.spring(), value: showClass)
                        .zIndex(3)
                }

                
                HStack {
                    Spacer()
                    ForEach(viewModel.Screens) { screen in
                        Button {
                            self.selected = screen.type
                        } label: {
                            LinearGradient(colors: screen.type == selected ? [.blue, .purple] : [.black], startPoint: .top, endPoint: .bottom).mask {
                                VStack(spacing: 0) {
                                    Image(systemName: screen.type == selected ? screen.image + ".fill" : screen.image)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.bottom, 4)
                                        .frame(width: 44, height: 29)
                                    Text(screen.type.description)
                                        .font(.system(size: 10))
                                        .lineLimit(1)
                                }.frame(maxWidth: .infinity)
                            }
                        }
                    }
                    Spacer()
                }.frame(height: 92, alignment: .top).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34))
            }
            .edgesIgnoringSafeArea(Edge.Set.bottom)
        }
        .navigationBarHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
