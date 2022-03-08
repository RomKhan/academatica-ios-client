//
//  CardStackVIewModel.swift
//  Academatica
//
//  Created by Roman on 09.03.2022.
//

import Foundation

class CardStackVIewModel : ObservableObject {
    @Published var cardData: [CardData] = []
    
    func fillCardStack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.cardData = [
                CardData(
                    id: 0, nameOfTopic: "Natural Numbers1",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation Decimal numbers and decimal notation Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 1, nameOfTopic: "Natural Numbers2",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 2, nameOfTopic: "Natural Numbers3",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 3, nameOfTopic: "Natural Numbers4",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 4, nameOfTopic: "Natural Numbers5",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 5, nameOfTopic: "Natural Numbers6",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 6, nameOfTopic: "Natural Numbers7",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 7, nameOfTopic: "Natural Numbers8",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100),
                CardData(
                    id: 8, nameOfTopic: "Natural Numbers9",
                    nameOfLesson: "Decimals",
                    descriptionOfLesson: "Decimal numbers and decimal notation",
                    countOfLessons: 4,
                    numberOfCurrentLesson: 2,
                    expCount: 100)
            ]
        }
    }
}
