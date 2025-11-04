struct BotLogic {
    
    enum Difficulty: Int {
        case easy = 0
        case medium = 1
        case hard = 2
    }

    static func makeMove(on board: [String], botSymbol: String, difficulty: Difficulty) -> Int? {
        switch difficulty {
        case .easy:
            return makeRandomMove(on: board)
        case .medium:
            return makeMediumMove(on: board, botSymbol: botSymbol)
        case .hard:
            return makeRandomMove(on: board)
        }
    }

    private static func makeRandomMove(on board: [String]) -> Int? {
        let emptyIndices = board.enumerated()
            .filter { $0.element.isEmpty }
            .map { $0.offset }

        return emptyIndices.randomElement()
    }

    private static func makeMediumMove(on board: [String], botSymbol: String) -> Int? {
        var tempBoard = board
        let playerSymbol = botSymbol == "X" ? "O" : "X"

        // 1️⃣ Проверка: можно ли выиграть самому
        for i in 0..<tempBoard.count {
            if tempBoard[i].isEmpty {
                tempBoard[i] = botSymbol
                if checkWinner(on: tempBoard) == botSymbol {
                    return i
                }
                tempBoard[i] = ""
            }
        }

        // 2️⃣ Проверка: можно ли заблокировать игрока
        for i in 0..<tempBoard.count {
            if tempBoard[i].isEmpty {
                tempBoard[i] = playerSymbol
                if checkWinner(on: tempBoard) == playerSymbol {
                    return i
                }
                tempBoard[i] = ""
            }
        }

        // 3️⃣ Иначе — случайный ход
        return makeRandomMove(on: board)
    }

    private static func checkWinner(on board: [String]) -> String? {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]
        
        for combo in winningCombinations {
            let a = combo[0], b = combo[1], c = combo[2]
            if board[a] != "", board[a] == board[b], board[b] == board[c] {
                return board[a]
            }
        }
        return nil
    }
}
