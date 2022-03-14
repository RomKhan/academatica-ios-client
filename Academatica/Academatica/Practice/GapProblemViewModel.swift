//
//  GapProblemViewModel.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import Foundation

struct GapProblemModel {
    let expression: String
    let correctAnswer: [String]
}

class GapProblemViewModel : ObservableObject {
    var model: GapProblemModel
    @Published var rows: [[String]] = []
    @Published var answersIndexes: [Int] = []
    @Published var answersLenghts: [Int] = []
    
    init(model: GapProblemModel) {
        self.model = model
        rows = parseExpresion()
        
    }
    
    func parseExpresion() -> [[String]] {
        var moduls = model.expression.components(separatedBy: "_")

        var answersIndex = 0
        for index in (0..<moduls.count) {
            if (moduls[index] == "GAP") {
                moduls[index] = model.correctAnswer[answersIndex]
                answersIndexes.append(index)
                answersLenghts.append(moduls[index].count)
                answersIndex += 1
            }
        }
        
        var rows: [[String]] = []
        
        var localLenght = 0
        var row: [String] = []
        for modul in moduls {
            if (modul.count + localLenght <= 11) {
                row.append(modul)
                localLenght += modul.count
            } else if (modul.count > 11) {
                rows.append(row)
                rows.append([modul])
                row.removeAll()
                localLenght = 0
            }
            else {
                rows.append(row)
                row.removeAll()
                localLenght = 0
            }
        }
        if (!row.isEmpty) {
            rows.append(row)
            row.removeAll()
            localLenght = 0
        }
        
        return rows
    }
}
