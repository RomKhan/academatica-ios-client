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
                Text("\(viewModel.topicModel.amountOfClasses) Lessons".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .blendMode(.overlay)
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 20)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(25)
        .matchedGeometryEffect(id: viewModel.topicModel.id, in: namespace)
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

struct TopicCardModel_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        TopicCardView(
            viewModel: TopicCardViewModel(topicModel: TopicModel(id: "0", name: "Units of measurement", description: "fdsfd", isAlgebraTopics: true, imageURL: "", isFineshed: false, amountOfClasses: 5, amoutTimeToComplete: 45)),
            show: .constant(true),
            namespace: namespace
        )
            .frame(height: UIScreen.main.bounds.height / 3.44)
            .padding(.horizontal, 20)
    }
}
