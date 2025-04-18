import UIKit

final class CustomFriendViewCell: UITableViewCell {
    private var imgFriend = UIImageView(image: UIImage(systemName: "person"))
    
    private var text: UILabel = {
        let label = UILabel()
        label.text = "Friend's Name"
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imgFriend)
        contentView.addSubview(text)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imgFriend.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgFriend.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 12),
            imgFriend.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgFriend.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            imgFriend.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgFriend.widthAnchor.constraint(equalToConstant: 40),
            imgFriend.heightAnchor.constraint(equalTo: imgFriend.widthAnchor),
            
            text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            text.leadingAnchor.constraint(equalTo: imgFriend.trailingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            text.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func setFriendName(_ name: String) {
        text.text = name
    }
}

