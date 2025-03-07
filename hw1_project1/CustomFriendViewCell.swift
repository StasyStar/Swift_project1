import UIKit

final class CustomFriendViewCell: UITableViewCell {
    private var oval: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.layer.cornerRadius = 30
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
        contentView.addSubview(oval)
        contentView.addSubview(text)
        setupConstraints()
    }
    
    private func setupConstraints() {
        oval.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            oval.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            oval.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            oval.heightAnchor.constraint(equalToConstant: 50),
            oval.widthAnchor.constraint(equalToConstant: 70),
            
            text.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            text.leadingAnchor.constraint(equalTo: oval.trailingAnchor, constant: 30),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
        ])
    }
    
    func setFriendName(_ name: String) {
        text.text = name
    }
}

