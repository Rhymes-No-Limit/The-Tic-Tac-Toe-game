import Foundation

struct BotLogic {
    
    enum Difficulty: Int {
        case easy = 0
        case medium = 1
        case hard = 2
    }

    static func makeMove(on board: [String], difficulty: Difficulty) -> Int? {
        switch difficulty {
        case .easy:
            return makeRandomMove(on: board)
        case .medium:
            return makeRandomMove(on: board) // позже добавим стратегию
        case .hard:
            return makeRandomMove(on: board) // потом — умный ИИ
        }
    }

    private static func makeRandomMove(on board: [String]) -> Int? {
        let emptyIndices = board.enumerated()
            .filter { $0.element.isEmpty }
            .map { $0.offset }

        return emptyIndices.randomElement()
    }
    
}
