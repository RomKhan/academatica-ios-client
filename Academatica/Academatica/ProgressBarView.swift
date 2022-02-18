//
//  ProgressBar.swift
//  Academatica
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI

struct ProgressBarView: View {
    @StateObject var viewModel: ProgressBarViewModel
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(height: 4)
                    .foregroundColor(Color(uiColor: UIColor(red: 192 / 255.0, green: 192 / 255.0, blue: 192 / 255.0, alpha: 1)).opacity(0.8))
                RoundedRectangle(cornerRadius: 100)
                    .frame(height: 4)
                    .frame(width: UIScreen.main.bounds.width / 100 * CGFloat(viewModel.percentages))
                    .foregroundColor(Color(uiColor: UIColor(red: 0, green: 221 / 255.0, blue: 62 / 255.0, alpha: 1)).opacity(0.8))
                    .shadow(color: Color(uiColor: UIColor(red: 67 / 255.0, green: 176 / 255.0, blue: 100 / 255.0, alpha: 1)), radius: 8, x: 0, y: 0)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(viewModel: ProgressBarViewModel(percentages: 56))
            .frame(height: 100)
    }
}
