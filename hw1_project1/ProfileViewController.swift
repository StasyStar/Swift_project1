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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(img)
        view.addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        img.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            img.widthAnchor.constraint(equalToConstant: 150),
            img.heightAnchor.constraint(equalToConstant: 150),
            
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}
