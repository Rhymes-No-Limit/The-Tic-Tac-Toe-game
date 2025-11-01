import UIKit

final class NewGameViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var modeSegment: UISegmentedControl!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.setGradientBackground(colors: [UIColor.lightGray.withAlphaComponent(0.8), UIColor.lightGray.withAlphaComponent(0.4)])
        
        let backButton = UIButton(type: .system)
            backButton.setTitle("←", for: .normal)
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
            backButton.setTitleColor(.white, for: .normal)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            backButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
            
            view.addSubview(backButton)
            
            NSLayoutConstraint.activate([
                backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                backButton.widthAnchor.constraint(equalToConstant: 100),
                backButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameFromNewGame",
             let gameVC = segue.destination as? GameViewController {
                
            let trimmedName = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            gameVC.playerName = trimmedName.isEmpty ? "Игрок" : trimmedName
            gameVC.isPlayingWithBot = modeSegment.selectedSegmentIndex == 1
            
            gameVC.title = "\(gameVC.playerName!) vc \(gameVC.isPlayingWithBot ? "Бот" : "Игрок 2")"
            
                
            
        }
    }
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Введите имя перед началом игры.", clearField: true)
        return
        }
        
        let regex = "^[A-Za-z]+$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
        
        guard isValid else {
            showAlert(message: "Имя должно состоять только из латинских букв.", clearField: true)
            return
        }
        
        performSegue(withIdentifier: "showGameFromNewGame", sender: self)
    }
    
    private func showAlert(message: String, clearField: Bool = false) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            if clearField {
                self?.nameTextField.text = ""
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func backToMenu() {
        dismiss(animated: false)
    }
    
 }
