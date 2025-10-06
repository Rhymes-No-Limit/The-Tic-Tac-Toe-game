import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var buttons: [UIButton]!
    
    // MARK: - Properties
    
    var currentPlayer = "X"
    var game = GameModel()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.setGradientBackground(colors: [UIColor.lightGray.withAlphaComponent(0.8), UIColor.lightGray.withAlphaComponent(0.4)])
        
        for button in buttons {
            button.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        game.makeMove(at: index)
        sender.setTitle(game.board[index], for: .normal)
        sender.isEnabled = false
        
        if let winner = game.checkWinner() {
            showWinnerAlert(winner)
        }
    }
    
    private func showWinnerAlert(_ winner: String) {
        let alert = UIAlertController(title: "Победа!", message: "\(winner) победил!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Новая игра", style: .default) { [weak self] _ in self?.resetGame()})
        present(alert, animated: true)
    }
    
    private func resetGame() {
        game = GameModel()
        buttons.forEach { $0.setTitle("", for: .normal); $0.isEnabled = true }
    }
}
