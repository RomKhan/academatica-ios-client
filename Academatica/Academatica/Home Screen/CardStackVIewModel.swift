//
//  CardStackVIewModel.swift
//  Academatica
//
//  Created by Roman on 09.03.2022.
//

import Foundation
import Combine

class CardStackViewModel : ObservableObject {
    @Published var cardData: [UpcomingClassModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        fillCardStack()
        
        CourseService.shared.$upcomingClasses.sink { [weak self] newValue in
            var newArray: [UpcomingClassModel] = []
            newArray.append(contentsOf: newValue)
            newArray.append(contentsOf: newValue)
            
            self?.cardData = newArray
        }.store(in: &cancellables)
    }
    
    func fillCardStack() {
        CourseService.shared.getUpcomingLessons()
    }
}
