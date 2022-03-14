//
//  TopicCardModel.swift
//  SmartMath
//
//  Created by Roman on 10.01.2022.
//

import SwiftUI

struct TopicCardView: View {
    @StateObject var viewModel: TopicCardViewModel
    @Binding var show: Bool
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(LinearGradient(gradient: viewModel.gradient, startPoint: .topTrailing, endPoint: .bottomLeading))
            VStack(alignment: .leading, spacing: 13) {
                Text(viewModel.topicModel.name)
                    .font(.system(size: 18, weight: .bold))
                Text("\(viewModel.topicModel.classCount) уроков".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .blendMode(.overlay)
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 20)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(Color.black.opacity(viewModel.topicModel.isUnlocked ? 0 : 0.5))
        .overlay(
            Image("locked")
                .resizable()
                .frame(width: 64, height: 64, alignment: .center)
                .opacity(viewModel.topicModel.isUnlocked ? 0 : 1)
        )
        .cornerRadius(25)
        .matchedGeometryEffect(id: viewModel.topicModel.id, in: namespace)
        .onTapGesture {
            if viewModel.topicModel.isUnlocked {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    CourseService.shared.currentTopic = viewModel.topicModel
                    show.toggle()
                }
            }
        }
    }
}

struct TopicCardModel_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        TopicCardView(
            viewModel: TopicCardViewModel(
                topicModel:
                    TopicModel(id: "0", name: "Topic", description: "Desc", isAlgebraTopic: true, imageUrl: nil, isComplete: false, isUnlocked: true, completionRate: 0, classCount: 2)),
            show: .constant(true),
            namespace: namespace
        )
            .frame(height: UIScreen.main.bounds.height / 3.44)
            .padding(.horizontal, 20)
    }
}
