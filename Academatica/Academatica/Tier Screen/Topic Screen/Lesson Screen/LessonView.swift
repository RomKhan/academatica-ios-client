//
//  LessonView.swift
//  SmartMath
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI
import Combine
import ResizableSheet

struct LessonView: View {
    @StateObject var viewModel: LessonViewModel
    @State private var heightOfset: CGFloat = 0
    @State private var practiceActive: Bool = false
//    @Binding var practiceShow: Bool
    @State var practiceShow: Bool = false
    @State private var webViewHeight: CGFloat = .zero
//    @Binding var state: ResizableSheetState
    @Binding var showSheet: Bool
//    @Binding var startPractise: Bool
    
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
//                        state = .hidden
                        showSheet.toggle()
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
//                .padding(.top, UIScreen.main.bounds.height / 30)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                LessonCardView(viewModel: LessonCardViewModel(lesson: viewModel.model, topicName: viewModel.topicName),
                               practivceIsActive: $practiceActive,
                               practiceShow: $practiceShow,
                               showSheet: $showSheet)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height / 8 - CGFloat(viewModel.model.descriptionId.count) / 5)
                Webview(type: .public, url: "https://vk.com", dynamicHeight: $webViewHeight)
                    .padding()
                    .frame(height: webViewHeight)
                Text("")
            }
            .onChange(of: heightOfset) { newValue in
                if (webViewHeight > 0 && UIScreen.main.bounds.height / 2 + heightOfset > webViewHeight) {
                    practiceActive = true
                }
            }
            if (webViewHeight <= 0) {
                VStack(spacing: 20) {
                    ProgressView()
                    Text("Идет загрузка урока")
                        .font(.system(size: UIScreen.main.bounds.height / 50, weight: .thin))
                }
                .offset(y: -UIScreen.main.bounds.height / 6 - heightOfset)
            }
            PracticeView(showPractice: $practiceShow)
                .offset(y: practiceShow ? 0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(), value: practiceShow)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:  .bottom)
        .background(.white)
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(
            viewModel: LessonViewModel(
                lesson: ClassModel(id: "1",
                                   TopicId: "1",
                                   TierId: "1",
                                   name: "Introduction",
                                   descriptionId: "What are natural numbers?",
                                   expRevards: 100,
                                   imageUrl: "",
                                   thearyUrl: "",
                                   problemNum: 10,
                                   status: 0),
                topicName: "Natural Numbers"),
//            practiceShow: .constant(false),
            showSheet: .constant(false)
//            , startPractise: .constant(false)
        )
    }
}
