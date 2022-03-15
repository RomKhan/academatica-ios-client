//
//  FullTopicCardView.swift
//  SmartMath
//
//  Created by Roman on 19.01.2022.
//

import SwiftUI

struct FullTopicCardView: View {
    @StateObject var viewModel: TopicViewModel
    var namespace: Namespace.ID
    private let height = UIScreen.main.bounds.height;
    
    var body: some View {
        VStack(alignment: .leading, spacing: height / 60) {
            Text(viewModel.topicModel.name)
                .font(.system(size: height / 33.8, weight: .heavy))
                .lineLimit(2)
            Text("\(viewModel.topicModel.classCount) уроков".uppercased())
                .font(.system(size: height / 67, weight: .bold))
                .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
            Text(viewModel.topicModel.description)
                .font(.system(size: height / 58))
                .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                .lineLimit(15)
            ProgressBarView(viewModel: ProgressBarViewModel(percentages: CGFloat(viewModel.topicModel.completionRate) / 100))
                .padding(.vertical, 10)
            Text("\(viewModel.topicModel.completionRate)% завершено")
                .font(.system(size: height / 58))
                .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                .frame(maxWidth: .infinity)
                .padding(.top, -8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background(.ultraThinMaterial)
        .cornerRadius(height / 32)
    }
}

struct FullTopicCardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        FullTopicCardView(viewModel: TopicViewModel(),
                          namespace: namespace)
            .background(LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: Color(#colorLiteral(red: 1, green: 0.01462487131, blue: 0.45694381, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.9612058997, green: 0.6234115958, blue: 0, alpha: 1)), location: 0.5)]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading))
    }
}
