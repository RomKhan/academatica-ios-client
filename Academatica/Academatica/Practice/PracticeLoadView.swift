//
//  PracticeView.swift
//  SmartMath
//
//  Created by Roman on 17.02.2022.
//

import SwiftUI

struct PracticeLoadView: View {
    @StateObject var viewModel: PracticeLoadViewModel
    @Binding var showPractice: Bool
    @State private var heightOfset: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            if viewModel.serverState == .success {
                PracticeView(viewModel: PracticeViewModel(type: viewModel.practiceType, problems: viewModel.practiceProblems, cancel: {
                    CourseService.shared.practiceLoaded = false
                    dismiss()
                    showPractice.toggle()
                }, expReward: viewModel.expReward, classId: viewModel.classId, topicId: viewModel.topicId))
            }
            
            ZStack {
                LoadingView(serverState: $viewModel.serverState, errorMessage: $viewModel.errorMessage)
                    .offset(y: -heightOfset)
                TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                    if viewModel.serverState == .error {
                        Button {
                            withAnimation {
                                showPractice.toggle()
                                dismiss()
                            }
                        } label: {
                            Text("Выйти")
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
            .background(.white)
            .opacity(viewModel.serverState == .success ? 0 : 1)
            .animation(.easeIn(duration: 0.2).delay(1), value: viewModel.serverState)
        }.onAppear() {
            if viewModel.practiceType == .lesson, let classId = viewModel.classId {
                viewModel.lessonPracticeLoad(id: classId)
            }
        }
    }
}

struct PracticeLoadView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeLoadView(viewModel: PracticeLoadViewModel(mode: .completedLessons, topicId: nil), showPractice: .constant(false))
    }
}
