//
//  LessonView.swift
//  SmartMath
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI
import Combine

struct LessonView: View {
    @StateObject var viewModel: LessonViewModel
    @State private var heightOfset: CGFloat = 0
    @State private var practiceActive: Bool = true
    @State var practiceShow: Bool = false
    @State private var webViewHeight: CGFloat = .zero
    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: viewModel.colors[1], location: 0.4),
                            .init(color: viewModel.colors[2], location: 1)]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading)
                    .offset(y: -UIScreen.main.bounds.height / 2)
                TopViewBackgroundBack()
                    .fill(viewModel.colors[0])
                    .offset(y: UIScreen.main.bounds.height * 0.43)
                TopViewBackgroundFront()
                    .fill(.white)
                    .offset(y: UIScreen.main.bounds.height * 0.43)
            }
            .animation(.easeOut, value: heightOfset)
            .offset(y: -heightOfset)
            .ignoresSafeArea()
            
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                HStack {
                    BuoysLeftCounter()
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showSheet.toggle()
                            CourseService.shared.currentTopic = CourseService.shared.currentTopic
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(Font.system(size: 15, weight: .bold))
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(2)
                            .background(.ultraThinMaterial)
                            .cornerRadius(100)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                LessonCardView(viewModel: LessonCardViewModel(lesson: viewModel.model, topicName: viewModel.topicName),
                               practivceIsActive: $practiceActive,
                               practiceShow: $practiceShow,
                               showSheet: $showSheet)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height / 8 - CGFloat(viewModel.model.description.count) / 5)
                Webview(type: .public, url: viewModel.model.theoryUrl.absoluteString, dynamicHeight: $webViewHeight)
                    .padding()
                    .frame(height: webViewHeight)
                Text("")
            }
            .onChange(of: heightOfset) { newValue in
                practiceActive = true
            }
            if (webViewHeight <= 0) {
                VStack(spacing: 20) {
                    ProgressView()
                    Text("Идет загрузка урока")
                        .font(.system(size: UIScreen.main.bounds.height / 50, weight: .thin))
                }
                .offset(y: -UIScreen.main.bounds.height / 6 - heightOfset)
            }
            PracticeLoadView(viewModel: PracticeLoadViewModel(lessonID: viewModel.classId), showPractice: $practiceShow)
                .offset(y: practiceShow ? 0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(), value: practiceShow)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:  .bottom)
        .background(.white)
        .onAppear() {
            if let currentClass = CourseService.shared.currentClass {
                viewModel.model = currentClass
            }
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(
            viewModel: LessonViewModel(
                lesson: ClassModel(id: "0", name: "classname", description: "desc", expReward: 100, imageUrl: nil, theoryUrl: URL(string: "https://google.com")!, problemNum: 10, topicName: "topicname", isComplete: false, isUnlocked: true),
                topicName: "Natural Numbers"),
            showSheet: .constant(false)
        )
    }
}
