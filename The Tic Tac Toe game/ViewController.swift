import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    
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
        sender.setTitle(currentPlayer, for: .normal)
        sender.isEnabled = false
        
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }
    
}

