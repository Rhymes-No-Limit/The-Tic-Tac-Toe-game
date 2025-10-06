import UIKit

class NewGameViewController: UIViewController {

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
        if segue.identifier == "showGameFromNewGame" {
            if let gameVC = segue.destination as? gameViewController {
                let playerName = nameTextField.text ?? "Игрок"
                let modeIndex = modeSegment.selectedSegmentIndex
                
                gameVC.title = "\(playerName) vs \(modeIndex == 0 ? "Игрок" : "Бот")"
                
            }
        }
    }
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showGameFromNewGame", sender: nil)
    }
    
    @objc private func backToMenu() {
        dismiss(animated: false)
    }
    
 }
