import UIKit

class NextViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(welcomeLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
