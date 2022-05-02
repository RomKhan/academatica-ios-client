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
                .overlay(
                    AsyncImage(
                        url: viewModel.topicModel?.imageUrl,
                        transaction: Transaction(animation: .spring()))
                    { phase in
                        switch phase {
                        case .success(let image):
                            Rectangle()
                                .fill(.clear)
                                .scaledToFit()
                                .background(
                                    image
                                        .resizable()
                                        .scaledToFill()
                                )
                        case .failure:
                            Rectangle()
                                .fill(.black.opacity(0.5))
                                .scaledToFit()
                                .background(
                                    Image(systemName: "wifi.slash")
                                        .resizable()
                                        .scaledToFill()
                                        .padding(25)
                                        .foregroundColor(.white)
                                )
                                .padding(UIScreen.main.bounds.height / 10)
                        case .empty:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                        .blendMode(.overlay)
                )
            
            VStack(alignment: .leading, spacing: 13) {
                Text(viewModel.topicModel?.name ?? "")
                    .font(.system(size: 18, weight: .bold))
                Text("\(viewModel.topicModel?.classCount ?? 0) уроков".uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .blendMode(.overlay)
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 20)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(Color.black.opacity(viewModel.topicModel?.isUnlocked ?? true ? 0 : 0.5))
        .overlay(
            Image("locked")
                .resizable()
                .frame(width: 64, height: 64, alignment: .center)
                .opacity(viewModel.topicModel?.isUnlocked ?? true ? 0 : 1)
        )
        .cornerRadius(25)
        .matchedGeometryEffect(id: viewModel.topicModel?.id, in: namespace)
        .onTapGesture {
            if viewModel.topicModel != nil && viewModel.topicModel!.isUnlocked {
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
            viewModel: TopicCardViewModel(topicId: ""),
            show: .constant(true),
            namespace: namespace
        )
            .frame(height: UIScreen.main.bounds.height / 3.44)
            .padding(.horizontal, 20)
    }
}
