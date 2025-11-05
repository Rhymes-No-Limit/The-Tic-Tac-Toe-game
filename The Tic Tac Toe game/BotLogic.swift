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
            return makeMediumMove(on: board)
        case .hard:
            return makeHardMove(on: board)
        }
    }

    // MARK: - Easy

    private static func makeRandomMove(on board: [String]) -> Int? {
        let emptyIndices = board.enumerated()
            .filter { $0.element.isEmpty }
            .map { $0.offset }

        return emptyIndices.randomElement()
    }

    // MARK: - Medium

    private static func makeMediumMove(on board: [String]) -> Int? {
        var tempBoard = board
        
        // 1. Попробовать выиграть
        for i in 0..<tempBoard.count where tempBoard[i].isEmpty {
            tempBoard[i] = "O"
            if checkWinner(on: tempBoard) == "O" { return i }
            tempBoard[i] = ""
        }
        
        // 2. Заблокировать игрока
        for i in 0..<tempBoard.count where tempBoard[i].isEmpty {
            tempBoard[i] = "X"
            if checkWinner(on: tempBoard) == "X" { return i }
            tempBoard[i] = ""
        }
        
        // 3. Если ничего — случайный ход
        return makeRandomMove(on: board)
    }

    // MARK: - Hard (умный Minimax + приоритеты)

    private static func makeHardMove(on board: [String]) -> Int? {
        var bestScore = Int.min
        var move: Int? = nil

        for i in 0..<board.count where board[i].isEmpty {
            var tempBoard = board
            tempBoard[i] = "O"
            let score = minimax(board: tempBoard, depth: 0, isMaximizing: false, alpha: Int.min, beta: Int.max)
            
            if score > bestScore {
                bestScore = score
                move = i
            }
        }
        return move
    }

    // MARK: - Minimax Algorithm with Alpha-Beta Pruning

    private static func minimax(board: [String], depth: Int, isMaximizing: Bool, alpha: Int, beta: Int) -> Int {
        if let winner = checkWinner(on: board) {
            switch winner {
            case "O": return 10 - depth
            case "X": return depth - 10
            default: return 0
            }
        }
        
        if !board.contains("") {
            return 0
        }
        
        var alpha = alpha
        var beta = beta
        var bestScore = isMaximizing ? Int.min : Int.max
        
        for i in 0..<board.count where board[i].isEmpty {
            var tempBoard = board
            tempBoard[i] = isMaximizing ? "O" : "X"
            
            let score = minimax(board: tempBoard, depth: depth + 1, isMaximizing: !isMaximizing, alpha: alpha, beta: beta)
            
            if isMaximizing {
                bestScore = max(bestScore, score)
                alpha = max(alpha, score)
            } else {
                bestScore = min(bestScore, score)
                beta = min(beta, score)
            }
            
            if beta <= alpha { break }
        }
        
        return bestScore
    }

    // MARK: - Check Winner

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
