import UIKit

final class CustomPhotoViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let textLabel = UILabel()
    var tap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with photo: Photo) {
        textLabel.text = photo.text
        
        if let imageUrl = URL(string: photo.url) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                guard let self = self else { return }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        textLabel.textColor = .white
        textLabel.font = .systemFont(ofSize: 12)
        textLabel.numberOfLines = 2
        textLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func handleTap() {
        tap?()
    }
}
