import UIKit

final class CustomPhotoViewCell: UICollectionViewCell {
    var tap: ((UIImage) -> Void)?
    private var imageView = UIImageView(image: UIImage(systemName: "person"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViws()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        addGestureRecognizer(recognizer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViws() {
        addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func cellTap() {
        tap?(imageView.image ?? UIImage())
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }

}
