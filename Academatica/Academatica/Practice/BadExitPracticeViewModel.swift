//
//  BadExitPracticeView.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import Foundation


class BadExitPracticeViewModel: ObservableObject {
    var cancelFunc: (() -> ())
    
    init(cancelFunc: @escaping (() -> ())) {
        self.cancelFunc = cancelFunc
    }
}
