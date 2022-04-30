//
//  CustomPracticeCardView.swift
//  Academatica
//
//  Created by Roman on 27.04.2022.
//

import SwiftUI

struct CustomPracticeCardView: View {
    var tool: CustomPracticeTopicModel
    var mode: CardMode
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(tool.name)
                .font(.system(size: 20).bold())
                .padding(5)
                .padding(.horizontal, 15)
                .padding(.top, 15)
                .lineLimit(2)
            Text(tool.isAlgebraTopic ? "Раздел Алгебры" : "Раздел Геометрии")
                .font(.system(size: 10))
                .padding(.horizontal, 20)
                .foregroundStyle(Color.black.opacity(0.65))
            Spacer()
            HStack {
                ArrowButton()
                    .frame(width: 6, height: 12)
                    .rotationEffect(Angle(degrees: 180))
                    .blendMode(.overlay)
                    .padding()
                    .padding(.trailing, -10)
                ZStack {
                    Text("Свайпни вправо, чтобы выбрать")
                        .font(.system(size: 11))
                        .blendMode(.overlay)
                    Text("Свайпни вправо, чтобы выбрать")
                        .font(.system(size: 11))
                        .blendMode(.overlay)
                        .opacity(0.5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: 125, alignment: .leading)
        .background(mode == .front ?
                    Color(uiColor: UIColor(
                        red: 239.0 / 255,
                        green: 239.0 / 255,
                        blue: 239.0 / 255,
                        alpha: 0.2)) :
                        mode == .middle ?
                    Color(uiColor: UIColor(
                        red: 239 / 255.0,
                        green: 147 / 255.0,
                        blue: 126 / 255.0,
                        alpha: 1)) :
                    Color(uiColor: UIColor(
                        red: 170 / 255.0,
                        green: 30 / 255.0,
                        blue: 245 / 255.0,
                        alpha: 1)))
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .opacity(mode == .none ? 0 : 1)
    }
    
}

struct CustomPractice_Previews: PreviewProvider {
    static var previews: some View {
        CustomPracticeCardView(tool: CustomPracticeTopicModel(id: "1", tierId: "0", name: "Натуральные числа1", description: "fdsfdfsdf", imageUrl: URL(string: "https://avatarko.ru/img/kartinka/33/multfilm_lyagushka_32117.jpg")!, isAlgebraTopic: true), mode: .middle)
            .padding()
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}

