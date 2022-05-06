//
//  ProblemViewModel.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import Foundation
import AVFAudio

enum ProblemType {
    case oneChoice
    case multiСhoice
    case withImage
    case solveProblem
    case gap
    
    static func getTypeFromString(text: String) -> ProblemType {
        switch text {
        case "gap":
            return .gap
        case "sc":
            return .oneChoice
        case "mc":
            return .multiСhoice
        case "txt":
            return .solveProblem
        case "pic":
            return .withImage
        default:
            return .oneChoice
        }
    }
}

enum ProblemState {
    case waiting
    case correctAnswer
    case incorrectAnswer
}

class ProblemViewModel: ObservableObject {
    var cancelFunc: ((Bool?) -> ())
    @Published var problemModel: ProblemModel
    var problemType: ProblemType
    @Published var problemState: ProblemState = .waiting
    @Published var answers: [String] = []
    @Published var correctAnswerString: String = ""
    private var audioPlayer: AVAudioPlayer!
    
    init(cancel: @escaping ((Bool?)->()), model: ProblemModel) {
        cancelFunc = cancel
        problemModel = model
        problemType = ProblemType.getTypeFromString(text: model.problemType)
        correctAnswerString = problemModel.correctAnswers.joined(separator: ", ")
        
        if (problemType == .gap) {
            for _ in (0 ..< problemModel.correctAnswers.count) {
                answers.append("")
            }
        } else if (problemType == .withImage || problemType == .solveProblem) {
            answers.append("")
        }
    }
    
    func checkAnswer() {
        var tempAnswers = answers
        for answer in problemModel.correctAnswers {
            if (!tempAnswers.contains(answer)) {
                problemState = .incorrectAnswer
                try! AVAudioSession.sharedInstance().setCategory(.playback)
                let sound = Bundle.main.path(forResource: "incorrect", ofType: "wav")
                audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!), fileTypeHint: "wav")
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                return
            }
            tempAnswers.remove(at: tempAnswers.firstIndex(of: answer)!)
        }
        
        problemState = .correctAnswer
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        let sound = Bundle.main.path(forResource: "correct", ofType: "wav")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!), fileTypeHint: "wav")
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}
