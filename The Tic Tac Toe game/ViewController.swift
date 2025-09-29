import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    
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
    
    var currentPlayer = "X"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for button in buttons {
            button.titleLabel?.font = .systemFont(ofSize: 72, weight: .bold)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
        }
        
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let placed = currentPlayer
        sender.setTitle(currentPlayer, for: .normal)
        sender.isEnabled = false
        
        if let winner = checkWinner() {
            handleWin(winner)
            return
        }
        
        if checkDraw() {
            handleDraw()
            return
        }
        
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }
    
    func checkWinner() -> String? {
        for combination in winningCombinations {
            let firstIndex = combination[0]
            let secondIndex = combination[1]
            let thirdIndex = combination[2]
            
            let firstTitle = buttons[firstIndex].title(for: .normal) ?? ""
            let secondTitle = buttons[secondIndex].title(for: .normal) ?? ""
            let thirdTitle = buttons[thirdIndex].title(for: .normal) ?? ""
            
            if firstTitle != "" && firstTitle == secondTitle && secondTitle == thirdTitle {
                return firstTitle // возвращает "X" или "O"
            }
        }
        return nil
    }
    
    func checkDraw() -> Bool {
        return buttons.allSatisfy { ($0.title(for: .normal) ?? "") != "" }
    }
    
    func handleWin(_ winner: String) {
        disableBoard()
        let alert = UIAlertController(title: "\(winner) выиграл!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Играть снова", style: .default) { _ in
            self.resetGame()
        })
        present(alert, animated: true)
    }

    func handleDraw() {
        disableBoard()
        let alert = UIAlertController(title: "Ничья", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Играть снова", style: .default) { _ in
            self.resetGame()
        })
        present(alert, animated: true)
    }

    func disableBoard() {
        for button in buttons { button.isEnabled = false }
    }
    
    func resetGame() {
        for button in buttons {
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        currentPlayer = "X"
    }
}

