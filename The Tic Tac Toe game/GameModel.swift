import Foundation

struct GameModel {
    var board: [String] = Array(repeating: "", count: 9)
    var currentPlayer: String = "X"
    
    mutating func makeMove(at index: Int) {
        guard board[index].isEmpty else { return }
        board[index] = currentPlayer
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }
    
    func checkWinner() -> String? {
        let winningCombinations: [[Int]] = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
            ]
        
        for combo in winningCombinations {
            let a = board[combo[0]], b = board[combo[1]], c = board[combo[2]]
            if a == b, b == c, !a.isEmpty {
                return a
            }
        }
        return nil
    }
}
