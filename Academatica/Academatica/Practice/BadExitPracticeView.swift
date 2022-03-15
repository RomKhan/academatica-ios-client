//
//  BadExitPracticeView.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import SwiftUI

struct BadExitPracticeView: View {
    @StateObject var viewModel: BadExitPracticeViewModel
    var body: some View {
        VStack {
            Text("Практика провалена".uppercased())
                .foregroundColor(.white)
                .font(.system(size: UIScreen.main.bounds.height / 35))
                .padding(.top, UIScreen.main.bounds.height / 25)
            LottieView(name: "losePractice", loopMode: .loop)
                .frame(height: UIScreen.main.bounds.width)
                .padding(.top, UIScreen.main.bounds.width / 10)
            Button {
                viewModel.cancelFunc()
            } label: {
                Text("Выйти")
                    .font(.system(size: UIScreen.main.bounds.height / 52, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .cornerRadius(UIScreen.main.bounds.height / 60)
                    .shadow(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 101 / 255.0, blue: 92 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
                    
            }
            .offset(y: UIScreen.main.bounds.height / 6)
            .padding(.horizontal, UIScreen.main.bounds.height / 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct BadExitPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        BadExitPracticeView(viewModel: BadExitPracticeViewModel(cancelFunc: {}))
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
