//
//  LessonCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 16.02.2022.
//
import SwiftUI
import Combine

class LessonCardViewModel: ObservableObject {
    @Published var model: ClassModel?
    var topicName: String = ""
    
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    init(topicName: String) {
        self.topicName = topicName
        
        CourseService.shared.$currentClass.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.model = newValue
            }
        }.store(in: &cancellables)
    }
}
