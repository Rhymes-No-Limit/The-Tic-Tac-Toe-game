import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.setGradientBackground(colors: [UIColor.lightGray.withAlphaComponent(0.8), UIColor.lightGray.withAlphaComponent(0.4)])
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false)
    }
    @IBAction func difficultySegmentTap(_ sender: UISegmentedControl) {
    }
    @IBAction func safeButtonTapped(_ sender: UIButton) {
    }
}
