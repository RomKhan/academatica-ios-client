//
//  CourseServices.swift
//  Academatica
//
//  Created by Roman on 08.03.2022.
//

import Foundation
import Combine

final class CourseServises {
    var buoysCount = CurrentValueSubject<Int?, Never>(nil)
    static var shared = CourseServises()
    private init() {}
    
    static func buoysCountUpdate() {
        DispatchQueue.global().async {
            sleep(2)
            CourseServises.shared.buoysCount.value = Int.random(in: (0...10))
        }
    }
}
