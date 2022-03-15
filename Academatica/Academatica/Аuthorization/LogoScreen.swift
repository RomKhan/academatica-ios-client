//
//  LoadScreen.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import SwiftUI

struct LogoScreen: View {
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Background()
                VStack {
                    ZStack {
                        Image(uiImage: UIImage(named: "center ball")!)
                            .offset(x: UIScreen.main.bounds.size.width/25)
                        Image(uiImage: UIImage(named: "logo")!)
                            .resizable()
                            .scaledToFit()
                            .padding(UIScreen.main.bounds.size.width/3.5)
                            .blendMode(.overlay)
                        Image(uiImage: UIImage(named: "logo")!)
                            .resizable()
                            .scaledToFit()
                            .padding(UIScreen.main.bounds.size.width/3.5)
                            .blendMode(.overlay)
                    }
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                }
            }
        }
    }
}

struct LoadScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogoScreen()
    }
}
