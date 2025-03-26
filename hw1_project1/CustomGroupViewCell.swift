import UIKit

final class CustomGroupViewCell: UITableViewCell {
    private var imgGroup = UIImageView(image: UIImage(systemName: "person.3"))
    
    private var text1: UILabel = {
        let label = UILabel()
        label.text = "Group's Name"
        label.textColor = .black
        return label
    }()
    
    private var text2: UILabel = {
        let label = UILabel()
        label.text = "Description"
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
        contentView.addSubview(imgGroup)
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imgGroup.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgGroup.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgGroup.widthAnchor.constraint(equalToConstant: 60),
            imgGroup.heightAnchor.constraint(equalToConstant: 40),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            text1.leadingAnchor.constraint(equalTo: imgGroup.trailingAnchor, constant: 16),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 8),
            text2.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text2.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            text2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}



