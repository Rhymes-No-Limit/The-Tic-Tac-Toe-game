import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var xScoreLabel: UILabel!
    @IBOutlet var oScoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    // MARK: - Properties
    
    var currentPlayer = "X"
    var game = GameModel()
    var xScore = 0
    var oScore = 0
    var turnTimer: Timer?
    var remainingTime = 10
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTurnTimer()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupUI()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        //startTurnTimer()
        handleMove(sender)
        
    }
    
    //MARK: - Game Logic
    
    private func handleMove(_ sender: UIButton) {
        let index = sender.tag
        game.makeMove(at: index)
        
        sender.setTitle(game.board[index], for: .normal)
        sender.isEnabled = false
        
        if let winner = game.checkWinner() {
            showWinnerAlert(winner)
            return
        }
        
        if !game.board.contains("") {
            showDrawAlert()
            return
        }
        
        startTurnTimer()
    }
    
    private func resetGame() {
        turnTimer?.invalidate()
        game = GameModel()
        buttons.forEach { $0.setTitle("", for: .normal); $0.isEnabled = true }
        
        remainingTime = 10
        startTurnTimer()
    }
    
    //MARK: - Timer
    
    private func startTurnTimer() {
        turnTimer?.invalidate()
        remainingTime = 10
        timerLabel.text = "Осталось: \(remainingTime)"
        
        turnTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.remainingTime -= 1
            self.timerLabel.text = "Осталось: \(self.remainingTime)"
            
            if self.remainingTime == 0 {
                timer.invalidate()
                self.switchTurnDueToTimer()
            }
        }
    }
    
    private func switchTurnDueToTimer() {
        game.currentPlayer = game.currentPlayer == "X" ? "O" : "X"
        startTurnTimer()
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        startTurnTimer()
    }
    
    
    // MARK: - Alerts
    
    private func showWinnerAlert(_ winner: String) {
        turnTimer?.invalidate()
        if winner == "X" {
            xScore += 1
        } else {
            oScore += 1
        }
        
        updateScoreLabels()
        
        let alert = UIAlertController(title: "Победа!", message: "\(winner) победил!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Новая игра", style: .default) { [weak self] _ in self?.resetGame()})
        present(alert, animated: true)
    }
    
    
    private func showDrawAlert() {
        turnTimer?.invalidate()
        let alert = UIAlertController(title: "Ничья!", message: "Никто не победил.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Новая игра", style: .default) { [weak self] _ in self?.resetGame()})
        present(alert, animated: true)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        
        view.setGradientBackground(colors: [UIColor.lightGray.withAlphaComponent(0.8), UIColor.lightGray.withAlphaComponent(0.4)])
        
        for button in buttons {
            button.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    private func updateScoreLabels() {
        xScoreLabel.text = "X: \(xScore)"
        oScoreLabel.text = "O: \(oScore)"
    }

}
