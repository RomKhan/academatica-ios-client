//
//  PracticeView.swift
//  Academatica
//
//  Created by Roman on 10.03.2022.
//

import SwiftUI
import Lottie

struct PracticeView: View {
    @StateObject var viewModel: PracticeViewModel
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selected) {
                ForEach ((0..<viewModel.problems.count), id: \.self) { index in
                    ProblemView(
                        index: viewModel.selected - CourseService.shared.lastMistakeCount,
                        problems_count: viewModel.problems.count - CourseService.shared.lastMistakeCount,
                        viewModel: ProblemViewModel(
                            cancel: viewModel.next,
                            model: viewModel.problems[index]))
                        .tag(index)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                        .simultaneousGesture(DragGesture())
                }
                
                SuccessPracticeMessageView(viewModel: SuccessPracticeMessageViewModel(exit: viewModel.cancel, cancelFunc: viewModel.finishPractice, classId: viewModel.classId, topicId: viewModel.topicId, practiceType: viewModel.practiceType, dismiss: viewModel.cancel), tagIndexSubstruct: $viewModel.tagIndexSubstract)
                    .tag(viewModel.problems.count)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .simultaneousGesture(DragGesture())
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: viewModel.selected)
            .transition(.opacity)
            .opacity(viewModel.showAchievements ? 0 : 1)
            .opacity(viewModel.badAnswerShow ? 0 : 1)
            .animation(.spring(), value: viewModel.badAnswerShow)
            .animation(.spring(), value: viewModel.showAchievements)
            
            ShowAchivementsView(viewModel: ShowAchivementsViewModel(achivements: viewModel.achievements, exit: viewModel.cancel))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .simultaneousGesture(DragGesture())
                .opacity(viewModel.showAchievements ? 1 : 0)
                .animation(.spring(), value: viewModel.showAchievements)
            
            BadExitPracticeView(viewModel: BadExitPracticeViewModel(cancelFunc: viewModel.cancel))
            .padding(.top, UIScreen.main.bounds.width / 9)
            .background(
                VisualEffectView(effect: UIBlurEffect(style: .dark)).ignoresSafeArea()
            )
            .opacity(viewModel.badExitShow ? 1 : 0)
            .animation(.spring(), value: viewModel.badExitShow)
            
            ZStack {
                VStack {
                    LottieView(name: "minus", loopMode: .playOnce)
                        .padding(100)
                        .blendMode(.overlay)
                    Group {
                        Text("Вы потеряли 1 спасательный круг")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .offset(y: -UIScreen.main.bounds.height / 3)
                }
                if (viewModel.badAnswerShowState == .error) {
                    Button {
                        viewModel.cancel()
                    } label: {
                        Text("Выйти")
                            .font(.system(size: UIScreen.main.bounds.height / 52, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .cornerRadius(UIScreen.main.bounds.height / 60)
                            .shadow(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 101 / 255.0, blue: 92 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 40)
                    .offset(y: UIScreen.main.bounds.height / 2.8)
                }
            }
            .transition(.opacity)
            .opacity(viewModel.badAnswerShow ? 1 : 0)
            .animation(.spring(), value: viewModel.badAnswerShow)
        }
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
        .ignoresSafeArea()
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(viewModel: PracticeViewModel(type: .lesson, problems: [
            ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания", task: "пример задания", problemType: "pic", options: ["1", "2", "3", "4"], imageUrl: URL(string: "https://res.cloudinary.com/dk-find-out/image/upload/q_70,c_pad,w_1200,h_630,f_auto/Geometry2_hdxtr9.jpg"), correctAnswers: ["1"], expression: "", difficulty: 1),
            ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания", task: "пример задания", problemType: "gap", options: ["1", "2", "3", "4"], imageUrl: URL(string: "https://res.cloudinary.com/dk-find-out/image/upload/q_70,c_pad,w_1200,h_630,f_auto/Geometry2_hdxtr9.jpg"), correctAnswers: ["1"], expression: "1+_GAP_=2", difficulty: 1),
            ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания!!!", task: "пример задания", problemType: "sc", options: ["1", "2", "3", "4"], imageUrl: nil, correctAnswers: ["1"], expression: "", difficulty: 1),
            ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания", task: "пример задания", problemType: "mc", options: ["1", "2", "3", "4"], imageUrl: nil, correctAnswers: ["1", "3"], expression: "", difficulty: 1),
            ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания", task: "dgfgdfgfdgdfgdbfg fgnyrtg erfewcefbgfbvcvdfv fddgfdsxsacd fgnyrtger fewcefbgfbvcvdfvf ddgfdsxsacd fgnyrtgerfewc efbgfbvcvdf vfddgfdsxsacd", problemType: "txt", options: ["1", "2", "3", "4"], imageUrl: nil, correctAnswers: ["1"], expression: "", difficulty: 1),
            ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания", task: "пример задания", problemType: "sc", options: ["1", "2", "3", "4"], imageUrl: nil, correctAnswers: ["1"], expression: "", difficulty: 1),
            
        ], cancel:{
            
        }, expReward: 100, classId: nil, topicId: nil))
    }
}
