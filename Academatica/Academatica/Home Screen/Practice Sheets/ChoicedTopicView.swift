//
//  CustomPracticeChoicedTopicView.swift
//  Academatica
//
//  Created by Roman on 28.04.2022.
//

import SwiftUI

struct ChoicedTopicView: View {
    @StateObject var viewModel: ChoicedTopicViewModel
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Menu {
                    Picker(selection: $viewModel.countOfTasks) {
                        ForEach((1...10), id: \.self) { index in
                            Text("\(index)")
                        }
                    } label: {}
                } label: {
                    Text("\(viewModel.countOfTasks)")
                        .font(.system(size: UIScreen.main.bounds.height / 27, weight: .bold))
                }
                Menu {
                    Picker(selection: $viewModel.difficulty) {
                        ForEach(["Легко", "Средне", "Сложно"], id: \.self) { index in
                            Text("\(index)")
                        }
                    } label: {}
                } label: {
                    Text(
                        viewModel.model.difficulty == .easy ? "Легко" :
                            viewModel.model.difficulty == .normal ? "Средне" : "Сложно"
                    )
                        .textCase(.uppercase)
                        .font(.system(size: UIScreen.main.bounds.height / 71))
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .frame(width: UIScreen.main.bounds.height / 11)
            .frame(maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: viewModel.gradient,
                    startPoint: .top,
                    endPoint: .bottom))
            VStack(alignment: .leading) {
                Text("Уровень \(CourseService.shared.customPracticeTiers.first(where: { value in viewModel.model.topicModel.tierId == value.id})?.name ?? "nan") \(viewModel.model.topicModel.isAlgebraTopic ? "Алгебра" : "Геометрия")"
                )
                    .font(.system(size: UIScreen.main.bounds.height / 67, weight: .bold))
                    .textCase(.uppercase)
                    .padding(.top, UIScreen.main.bounds.height / 70)
                
                Spacer()
                Text(viewModel.model.topicModel.name)
                    .font(.system(size: UIScreen.main.bounds.height / 45, weight: .bold))
                Spacer()
                Text(viewModel.model.topicModel.name)
                    .font(.system(size: UIScreen.main.bounds.height / 67, weight: .regular))
                    .foregroundColor(.gray.opacity(0.8))
                    .padding(.bottom, UIScreen.main.bounds.height / 70)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            ArrowButton()
                .frame(width: 6, height: 12)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 10, alignment: .leading)
        
    }
}

struct ChoicedTopicView_Previews: PreviewProvider {
    static var previews: some View {
        ChoicedTopicView(viewModel: ChoicedTopicViewModel(model: ChoicedTopicModel(difficulty: .normal, topicModel: CustomPracticeTopicModel(id: "1", tierId: "0", name: "Натуральные числа1", description: "fdsfdfsdf", imageUrl: URL(string: "https://avatarko.ru/img/kartinka/33/multfilm_lyagushka_32117.jpg")!, isAlgebraTopic: true), countOfTasks: 10)))
            .background(.white)
            .border(.black)
    }
}
