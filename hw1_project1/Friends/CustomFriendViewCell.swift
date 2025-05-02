import UIKit

final class CustomFriendViewCell: UITableViewCell {
    private var imgFriend: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private var onlineCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    
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
        contentView.addSubview(imgFriend)
        contentView.addSubview(onlineCircle)
        contentView.addSubview(text)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imgFriend.translatesAutoresizingMaskIntoConstraints = false
        onlineCircle.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgFriend.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 12),
            imgFriend.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgFriend.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            imgFriend.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgFriend.widthAnchor.constraint(equalToConstant: 40),
            imgFriend.heightAnchor.constraint(equalTo: imgFriend.widthAnchor),
            
            onlineCircle.widthAnchor.constraint(equalToConstant: 12),
            onlineCircle.heightAnchor.constraint(equalToConstant: 12),
            onlineCircle.bottomAnchor.constraint(equalTo: imgFriend.bottomAnchor),
            onlineCircle.trailingAnchor.constraint(equalTo: imgFriend.trailingAnchor),
            
            text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            text.leadingAnchor.constraint(equalTo: imgFriend.trailingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            text.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func updateCell(model: Friend) {
        text.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        let customGreen = UIColor(red: 27/255, green: 102/255, blue: 20/255, alpha: 1)
        let customRed = UIColor(red: 168/255, green: 25/255, blue: 25/255, alpha: 1)
        onlineCircle.backgroundColor = model.online == 1 ? customGreen : customRed
        
        if let url = URL(string: model.photo100) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgFriend.image = image
                    }
                }
            }
        } else {
            imgFriend.image = UIImage(systemName: "person")
        }
    }
    
    func setFriendName(_ name: String) {
        text.text = name
    }
}

