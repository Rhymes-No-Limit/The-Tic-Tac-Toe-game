import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    @IBAction func newGameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "newGame", sender: self)
    }
    
    @IBAction func settings(_ sender: UIButton) {
    }
    
    @IBAction func exitTapped(_ sender: UIButton) {
    }
    
}
