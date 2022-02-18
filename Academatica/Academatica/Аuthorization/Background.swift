//
//  Background.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

struct Background: View {
    private static let colors = [
        Color(uiColor: UIColor(red: 237 / 255.0, green: 123 / 255.0, blue: 218 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 92 / 255.0, green: 15 / 255.0, blue: 159 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 25 / 255.0, green: 1 / 255.0, blue: 167 / 255.0, alpha: 1))
    ]
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Circle()
                    .fill(Background.colors[2])
                    .frame(width: reader.size.width / 1.5)
                    .offset(x: -reader.size.width / 2.6, y: reader.size.height / 2.15)
                    .blur(radius: 100)
                Ellipse()
                    .fill(Background.colors[0])
                    .frame(width: reader.size.width / 1.6, height: reader.size.height / 2)
                    .rotationEffect(Angle(degrees: -15))
                    .offset(y: -reader.size.height / 2.8)
                    .blur(radius: 80)
                Ellipse()
                    .fill(Background.colors[1])
                    .frame(width: reader.size.width / 1.8, height: reader.size.height / 2)
                    .rotationEffect(Angle(degrees: -10))
                    .offset(x: reader.size.width / 3, y: -reader.size.height / 2.3)
                    .blur(radius: 105)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .blur(radius: 5)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: Background.colors[0], location: -0.1),
                            .init(color: Background.colors[1], location: 0.5),
                            .init(color: Background.colors[2], location: 1.1)
                        ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
