import UIKit

class NewGameViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var modeSegment: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameFromNewGame" {
            if let gameVC = segue.destination as? ViewController {
                let playerName = nameTextField.text ?? "Игрок"
                let modeIndex = modeSegment.selectedSegmentIndex
                
                gameVC.title = "\(playerName) vs \(modeIndex == 0 ? "Игрок" : "Бот")"
                
            }
        }
    }
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showGameFromNewGame", sender: nil)
    }
    
 }
