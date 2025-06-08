import UIKit

final class ImageViewController: UIViewController {
    private var imageView = UIImageView()
    private var textLabel = UILabel()
    private let randomTexts = [
        "Hello, world!",
        "Swift is awesome!",
        "Random text here",
        "This is a test",
        "Image with text",
        "Have a nice day!",
        "Coding is fun",
        "Keep learning",
        "Stay curious",
        "Make it happen"
    ]
    private var themeView = ThemeView()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        themeView.delegate = self
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
    }
    
    private func setupAppearance() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.textColor]
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        textLabel.text = randomTexts.randomElement() ?? "Default text"
        textLabel.textAlignment = .center
        textLabel.textColor = Theme.currentTheme.textColor
        view.addSubview(textLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let image = imageView.image else { return }
        let aspectRatio = image.size.height / image.size.width
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

extension ImageViewController: ThemeViewDelegate {
    func updateColor() {
        setupAppearance()
    }
}
