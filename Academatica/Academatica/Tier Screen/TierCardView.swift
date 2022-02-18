//
//  TierCardView.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI

struct TierCardView: View {
    @StateObject var viewModel: TierCardViewModel
    var body: some View {
        GeometryReader { reader in
            HStack(spacing: 0) {
                ArrowButton()
                    .frame(width: 8, height: 10)
                    .blendMode(.overlay)
                    .padding()
                VStack {
                    HStack(alignment: .top) {
                        VStack(spacing: -3) {
                            Text(viewModel.model.name)
                                .font(.system(size: 72, weight: .heavy))
                            Text("Уровень")
                                .font(.system(size: 13, weight: .bold)).textCase(.uppercase)
                        }
                        .blendMode(.overlay)
                        .padding(.trailing, 10)
                        
                        Text(viewModel.model.description)
                            .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                            .font(.system(size: 14))
                            .padding(.top, 15)
                            .lineLimit(4)
                            .frame(height: 100)
                    }
                    Spacer()
                    ProgressBarView(viewModel: ProgressBarViewModel(percentages: viewModel.model.finishedPercentage)).padding(.bottom, 10)
                    Text("\(viewModel.model.finishedPercentage)% завершено")
                        .padding(.bottom, 15)
                        .font(.system(size: 13))
                        .foregroundColor(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
                ArrowButton()
                    .frame(width: 8, height: 10)
                    .rotationEffect(Angle(degrees: 180))
                    .blendMode(.overlay)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 200)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
    }
}

struct TierCardView_Previews: PreviewProvider {
    static var previews: some View {
        TierCardView(viewModel:
                        TierCardViewModel(model:
                                            TierModel(id: "sfd",
                                                      name: "4",
                                                      description: "Introduction to geometry, units of measurement, simple equations, more about arithmetic operations.",
                                                      imageUrl: "",
                                                      finishedPercentage: 56,
                                                      isFineshed: false)))
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
