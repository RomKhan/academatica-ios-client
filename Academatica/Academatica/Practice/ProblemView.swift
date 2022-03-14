//
//  ProblemView.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import SwiftUI

struct ProblemView: View {
    var index: Int
    var problems_count: Int
    @StateObject var viewModel: ProblemViewModel
    var body: some View {
        GeometryReader { reader in
            ScrollView(showsIndicators: false) {
                ZStack {
                    HStack {
                        Button {
                            viewModel.cancelFunc(nil)
                        } label: {
                            Image(systemName: "xmark")
                                .font(Font.system(size: 15, weight: .bold))
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(2)
                                .background(.ultraThinMaterial)
                                .cornerRadius(100)
                        }
                        Spacer()
                        BuoysLeftCounter()
                    }
                    
                    VStack(spacing: 4) {
                        Text("\(index + 1) / \(problems_count)")
                            .font(Font.system(size: UIScreen.main.bounds.height / 47, weight: .bold))
                            .foregroundColor(.white)
                        ProgressBarView(viewModel: ProgressBarViewModel(percentages: CGFloat(index) / CGFloat(problems_count)))
                            .offset(y: 2)
                            
                    }
                    .offset(y: 3)
                    .frame(maxWidth: UIScreen.main.bounds.width / 4)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                
                Text(viewModel.problemModel.description)
                    .font(.system(size: UIScreen.main.bounds.height / 33.8, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height / 30)
                
                Group {
                switch viewModel.problemType {
                case .oneChoice:
                    ChoiceView(multichoice: false, viewModel: ChoiceViewModel(model: ChoiceModel(options: viewModel.problemModel.options, correctAnswers: viewModel.problemModel.correctAnswers)), state: $viewModel.problemState, selected: $viewModel.answers)
                case .multiСhoice:
                    ChoiceView(multichoice: true, viewModel: ChoiceViewModel(model: ChoiceModel(options: viewModel.problemModel.options, correctAnswers: viewModel.problemModel.correctAnswers)), state: $viewModel.problemState, selected: $viewModel.answers)
                case .withImage:
                    ProblemWithImageView(
                        viewModel: ProblemWithImageViewModel(
                            model: ProblemWithImageModel(
                                imageUrl: viewModel.problemModel.imageUrl!,
                                correctAnswer: viewModel.problemModel.correctAnswers)),
                            state: $viewModel.problemState,
                            selected: $viewModel.answers)
                case .gap:
                    GapProblemView(viewModel: GapProblemViewModel(model: GapProblemModel(expression: viewModel.problemModel.expression!, correctAnswer: viewModel.problemModel.correctAnswers)), state: $viewModel.problemState, selected: $viewModel.answers)
                        .padding(.top, UIScreen.main.bounds.height / 10)
                case .solveProblem:
                    SolveProblemView(
                        viewModel: SolveProblemViewModel(
                            model: SolveProblemModel(
                                text: viewModel.problemModel.task,
                                correctAnswer: viewModel.problemModel.correctAnswers)),
                            state: $viewModel.problemState,
                            selected: $viewModel.answers)
                }
                }
                .padding(.horizontal, 20)
                .frame(height: UIScreen.main.bounds.height / 2, alignment: .top)
                
                if (viewModel.problemState == .waiting) {
                    Button {
                        viewModel.checkAnswer()
                    } label: {
                        Text("Проверить".uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: UIScreen.main.bounds.height / 55, weight: .bold))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: UIColor(red: 0, green: 212 / 255.0, blue: 212 / 255.0, alpha: 1)))
                    .cornerRadius(UIScreen.main.bounds.height / 60)
                    .padding(.horizontal, 40)
                    .padding(.top, UIScreen.main.bounds.height / 8)
                    .shadow(color: Color(uiColor: UIColor(red: 0, green: 212 / 255.0, blue: 212 / 255.0, alpha: 1)), radius: 8, x: 0, y: 0)
                }
            }
            
            if viewModel.problemState == .incorrectAnswer {
                ZStack {
                VStack {
                    Text("Упс, ответ неверный!")
                        .foregroundColor(.white)
                        .font(.system(size: UIScreen.main.bounds.height / 45, weight: .bold))
                    Text("Верный ответ: \(viewModel.correctAnswerString)")
                        .foregroundColor(.white)
                        .font(.system(size: UIScreen.main.bounds.height / 45, weight: .light))
                        .padding()
                    Button {
                        viewModel.cancelFunc(false)
                    } label: {
                        Text("Продолжить".uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: UIScreen.main.bounds.height / 55, weight: .bold))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: UIColor(red: 1, green: 69 / 255.0, blue: 107 / 255.0, alpha: 1)))
                    .cornerRadius(UIScreen.main.bounds.height / 60)
                    .shadow(color: Color(uiColor: UIColor(red: 1, green: 69 / 255.0, blue: 107 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 40)
                .padding()
                .padding(.bottom, 200)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
                .cornerRadius(20)
                .offset(y: 170)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            } else if viewModel.problemState == .correctAnswer {
                ZStack {
                VStack {
                    Text("Отлично, ответ верный!")
                        .foregroundColor(.white)
                        .font(.system(size: UIScreen.main.bounds.height / 55, weight: .bold))
                    Button {
                        viewModel.cancelFunc(viewModel.problemState == .incorrectAnswer ? false : true)
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
                }
                .padding(.horizontal, 40)
                .padding()
                .padding(.bottom, 200)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
                .cornerRadius(20)
                .offset(y: 170)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .transition(.opacity)
        .animation(viewModel.problemType != .withImage &&
                   viewModel.problemType != .solveProblem &&
                   viewModel.problemType != .gap ?
                    .spring() : .linear(duration: 0), value: viewModel.problemState)
    }
}

struct ProblemView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemView(index: 1, problems_count: 10, viewModel: ProblemViewModel(cancel: {_ in }, model: ProblemModel(id: "ff1", classId: "fff", topicId: "fff", description: "Пример описания", task: " ihsihodf fdsfosh udfhsdfi shf uhdsfu fgsdfdshifsdfs", problemType: "gap", options: ["1", "2", "3", "4"], imageUrl: URL(string: "https://cdn2.vectorstock.com/i/1000x1000/40/71/definition-of-geometry-vector-22954071.jpg"), correctAnswers: ["1"], expression: "1+_GAP_=2", difficulty: 1)))
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
