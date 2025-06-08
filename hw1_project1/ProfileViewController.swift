import UIKit

final class ProfileViewController: UIViewController {
    private var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "hqdefault")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Кот Пушин"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var themeView = ThemeView()
    private var isCurrentUser: Bool

    // Конструктор для профиля текущего пользователя
    init(name: String? = nil, photo: UIImage? = nil) {
        self.isCurrentUser = true
        super.init(nibName: nil, bundle: nil)
        label.text = name ?? "Кот Пушин"
        img.image = photo
        themeView.delegate = self
    }
    
    // Конструктор для профиля друга
    init(friend: Friend) {
        self.isCurrentUser = false
        super.init(nibName: nil, bundle: nil)
        label.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")"
        if let url = URL(string: friend.photo100) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.img.image = image
                    }
                }
            }
        } else {
            self.img.image = UIImage(systemName: "person.circle.fill")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateColor()
    }

    private func setupViews() {
        view.addSubview(img)
        view.addSubview(label)
        if isCurrentUser {
            view.addSubview(themeView)
            themeView.delegate = self
        }
        setupConstraints()
    }

    private func setupConstraints() {
        img.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        themeView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = [
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            img.widthAnchor.constraint(equalToConstant: 150),
            img.heightAnchor.constraint(equalToConstant: 150),

            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
        ]
        
        if isCurrentUser {
            constraints += [
                themeView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
                themeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                themeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                themeView.heightAnchor.constraint(equalToConstant: 200)
            ]
        }

        NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController: ThemeViewDelegate {
    func updateColor() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        label.textColor = Theme.currentTheme.textColor
    }
}
