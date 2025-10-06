import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
            titleLabel.text = "Крестики-нолики"
            titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
            titleLabel.textColor = .black
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.setGradientBackground(colors: [UIColor.lightGray.withAlphaComponent(0.8), UIColor.lightGray.withAlphaComponent(0.4)])
    }
        

    @IBAction func newGameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showNewGame", sender: self)
    }
    
    @IBAction func settings(_ sender: UIButton) {
    }
    
    @IBAction func exitTapped(_ sender: UIButton) {
    }
    
}
