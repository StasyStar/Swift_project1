import UIKit

final class CustomGroupViewCell: UITableViewCell {
    private var imgGroup = UIImageView()
    
    private var text1: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var text2: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            imgGroup.widthAnchor.constraint(equalToConstant: 50),
            imgGroup.heightAnchor.constraint(equalToConstant: 50),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            text1.leadingAnchor.constraint(equalTo: imgGroup.trailingAnchor, constant: 16),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 8),
            text2.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text2.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            text2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    func updateCell(model: Group) {
        text1.text = model.name
        text2.text = "Участников: \(model.membersCount)"
        imgGroup.tintColor = Theme.currentTheme.textColor
        if let url = URL(string: model.photo100) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgGroup.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.imgGroup.image = UIImage(systemName: "person.3")
                        self.imgGroup.contentMode = .scaleAspectFill
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyTheme()
    }
    
    private func applyTheme() {
        contentView.backgroundColor = Theme.currentTheme.cellBackgroundColor
        backgroundColor = Theme.currentTheme.cellBackgroundColor
        text1.textColor = Theme.currentTheme.textColor
        text2.textColor = Theme.currentTheme.textColor
        imgGroup.tintColor = Theme.currentTheme.textColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgGroup.image = nil
    }
}



