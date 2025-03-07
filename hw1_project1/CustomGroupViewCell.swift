import UIKit

final class CustomGroupViewCell: UITableViewCell {
    private var oval: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 30
        return view
    }()
    
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
        contentView.addSubview(oval)
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        setupConstraints()
    }
    
    private func setupConstraints() {
        oval.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            oval.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            oval.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            oval.heightAnchor.constraint(equalToConstant: 50),
            oval.widthAnchor.constraint(equalToConstant: 70),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            text1.leadingAnchor.constraint(equalTo: oval.trailingAnchor, constant: 30),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 10),
            text2.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text2.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
        ])
    }
}



