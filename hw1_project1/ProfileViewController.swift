import UIKit

final class ProfileViewController: UIViewController {
    private var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "hqdefault")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Кот Пушин"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var themeView = ThemeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        themeChange()
        themeView.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(img)
        view.addSubview(label)
        view.addSubview(themeView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        img.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        themeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            img.widthAnchor.constraint(equalToConstant: 150),
            img.heightAnchor.constraint(equalToConstant: 150),
            
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
            
            themeView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            themeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            themeView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension ProfileViewController: ThemeViewDelegate {
    func themeChange() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        label.textColor = Theme.currentTheme.textColor
    }
}
