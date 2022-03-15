import Foundation

struct SolveProblemModel {
    let text: String
    let correctAnswer: [String]
}

class SolveProblemViewModel: ObservableObject {
    var model: SolveProblemModel
    
    init(model: SolveProblemModel) {
        self.model = model
    }
}
