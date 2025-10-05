import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var buttons: [UIButton]!
    
    // MARK: - Properties
    
    var currentPlayer = "X"
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for button in buttons {
            button.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.setTitle(currentPlayer, for: .normal)
        sender.isEnabled = false
        
        
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }
}
