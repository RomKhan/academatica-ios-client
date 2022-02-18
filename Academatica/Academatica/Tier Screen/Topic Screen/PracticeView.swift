//
//  PracticeView.swift
//  SmartMath
//
//  Created by Roman on 17.02.2022.
//

import SwiftUI

struct PracticeView: View {
    @Binding var showPractice: Bool
    var body: some View {
        VStack {
        Button {
            withAnimation {
                showPractice.toggle()
            }
        } label: {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(showPractice: .constant(false))
    }
}
