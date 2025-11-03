import UIKit

final class SettingsViewController: UIViewController {

    // подключи в сториборде
    @IBOutlet var difficultySegment: UISegmentedControl!
    
    // текущее выбранное значение (локально)
    private var selectedDifficulty: BotLogic.Difficulty = .easy

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedDifficulty()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground(colors: [UIColor.lightGray.withAlphaComponent(0.8),
                                            UIColor.lightGray.withAlphaComponent(0.4)])
    }
    
    // MARK: - Actions
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false)
    }

    @IBAction func difficultySegmentTap(_ sender: UISegmentedControl) {
        // обновляем локальную переменную при смене сегмента
        let idx = sender.selectedSegmentIndex
        selectedDifficulty = BotLogic.Difficulty(rawValue: idx) ?? .easy
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveDifficulty(selectedDifficulty)
        // небольшой алерт — подтверждение
        let alert = UIAlertController(title: "Сохранено",
                                      message: "Сложность установлена: \(label(for: selectedDifficulty))",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            self?.dismiss(animated: false)
        })
        present(alert, animated: false)
    }
    
    // MARK: - Helpers
    
    private func loadSavedDifficulty() {
        let raw = UserDefaults.standard.integer(forKey: "gameDifficulty")
        let diff = BotLogic.Difficulty(rawValue: raw) ?? .easy
        selectedDifficulty = diff
        difficultySegment.selectedSegmentIndex = diff.rawValue
    }
    
    private func saveDifficulty(_ difficulty: BotLogic.Difficulty) {
        UserDefaults.standard.set(difficulty.rawValue, forKey: "gameDifficulty")
    }
    
    private func label(for difficulty: BotLogic.Difficulty) -> String {
        switch difficulty {
        case .easy: return "Лёгкий"
        case .medium: return "Средний"
        case .hard: return "Сложный"
        }
    }
}
