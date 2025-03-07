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
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        textLabel.text = randomTexts.randomElement() ?? "Default text" 
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        view.addSubview(textLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), // Текст под изображением
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

