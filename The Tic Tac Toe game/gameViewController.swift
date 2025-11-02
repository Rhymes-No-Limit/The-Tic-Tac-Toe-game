import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var xScoreLabel: UILabel!
    @IBOutlet var oScoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var currentPlayerLabel: UILabel!
    
    // MARK: - Properties
    
    var currentPlayer = "X"
    var game = GameModel()
    var xScore = 0
    var oScore = 0
    var turnTimer: Timer?
    var remainingTime = 10
    var playerName: String?
    var opponentName: String? 
    var isPlayingWithBot: Bool = false
    var lastWinner: String? = nil
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTurnTimer()
        updateCurrentPlayerLabel()
        
        print(opponentName ?? "nil")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
        updateScoreLabels()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func resetGameTapped(_ sender: UIButton) {
        resetGame()
        updateCurrentPlayerLabel()
        
    }
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
        updateCurrentPlayerLabel()
        startTurnTimer()
        
        if isPlayingWithBot && game.currentPlayer == "O" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                
                if let botMoveIndex = BotLogic.makeMove(on: self.game.board, difficulty: .easy) {
                    let botButton = self.buttons[botMoveIndex]
                    self.handleMove(botButton)
                }
            }
        }
    }
    
    private func resetGame() {
        turnTimer?.invalidate()
        game = GameModel()
        buttons.forEach { $0.setTitle("", for: .normal); $0.isEnabled = true }
        
        if let winner = lastWinner {
            game.currentPlayer = winner
        } else {
            game.currentPlayer = "X"
        }
        
        remainingTime = 10
        updateCurrentPlayerLabel()
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
        updateCurrentPlayerLabel()
        startTurnTimer()
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        startTurnTimer()
    }
    
    
    // MARK: - Alerts
    
    private func showWinnerAlert(_ winner: String) {
        turnTimer?.invalidate()
        
        lastWinner = winner
        
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
        let playerDisplayName = playerName ?? "Игрок"
        let opponentDisplayName: String
        
        if isPlayingWithBot {
            opponentDisplayName = "Бот"
        } else {
            opponentDisplayName = opponentName ?? "Игрок 2"
        }
        
        xScoreLabel.text = "\(playerDisplayName): \(xScore)"
        oScoreLabel.text = "\(opponentDisplayName): \(oScore)"
    }
    
    private func updateCurrentPlayerLabel() {
        let playerDisplayName = playerName ?? "Игрок"
        let opponentDisplayName = isPlayingWithBot ? "Бот" : (opponentName ?? "Игрок 2")
        
        if game.currentPlayer == "X" {
            currentPlayerLabel.text = "Ход: \(playerDisplayName)"
        } else {
            currentPlayerLabel.text = "Ход: \(opponentDisplayName)"
        }
    }

}
