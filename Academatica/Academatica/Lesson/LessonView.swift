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
                AsyncImage(
                    url: viewModel.model?.imageUrl,
                    transaction: Transaction(animation: .spring()))
                { phase in
                    switch phase {
                    case .success(let image):
                        Rectangle()
                            .fill(.clear)
                            .scaledToFill()
                            .background(
                                image
                                    .resizable()
                                    .scaledToFill()
                            )
                    case .failure:
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .scaledToFill()
                            .background(
                                Image(systemName: "wifi.slash")
                                    .resizable()
                                    .scaledToFill()
                                    .padding(25)
                                    .foregroundColor(.white)
                            )
                    case .empty:
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .offset(y: -UIScreen.main.bounds.height / 4.5)
                .frame(maxHeight: UIScreen.main.bounds.height / 1.8)
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
                LessonCardView(viewModel: LessonCardViewModel(topicName: viewModel.topicName),
                               practivceIsActive: $practiceActive,
                               practiceShow: $practiceShow,
                               showSheet: $showSheet)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height / 8 - CGFloat(viewModel.model?.description.count ?? 0) / 5)
                WebView(type: .public, url: viewModel.model?.theoryUrl?.absoluteString, dynamicHeight: $webViewHeight)
                    .padding()
                    .background(.white)
                    .frame(height: webViewHeight)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:  .bottom)
        .background(
            LinearGradient(gradient: Gradient(
                stops: [
                    .init(color: viewModel.colors[1], location: 0),
                    .init(color: viewModel.colors[2], location: heightOfset > UIScreen.main.bounds.height / 2 ? 0.2 : 0.6),
                    .init(color: .white, location: heightOfset > UIScreen.main.bounds.height / 2 ? 0.2 : 1.5)
                ]),
                           startPoint: .topTrailing,
                           endPoint: .bottomLeading)
        )
        .fullScreenCover(isPresented: $practiceShow) {
            PracticeLoadView(viewModel: PracticeLoadViewModel(lessonID: viewModel.classId), showPractice: .constant(true))
            //                .offset(y: practiceShow ? 0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(), value: practiceShow)
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(
            viewModel: LessonViewModel(
                topicName: "Natural Numbers"),
            showSheet: .constant(false)
        )
    }
}
