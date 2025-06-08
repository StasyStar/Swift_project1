import UIKit

protocol ThemeViewDelegate: AnyObject {
    func updateColor()
}

final class ThemeView: UIView {
    weak var delegate: ThemeViewDelegate?
    private var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Стандартная тема", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.backgroundColor = StandartTheme().buttonColor
        button.setTitleColor(StandartTheme().textColor, for: .normal)
        return button
    }()
    
    private var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Пурпурная тема", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.backgroundColor = PurpleTheme().buttonColor
        button.setTitleColor(PurpleTheme().textColor, for: .normal)
        return button
    }()
    
    private var button3: UIButton = {
        let button = UIButton()
        button.setTitle("Персиковая тема", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.backgroundColor = PeachTheme().buttonColor
        button.setTitleColor(PeachTheme().textColor, for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.currentTheme.backgroundColor
        button1.addTarget(self, action: #selector(tap1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tap2), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tap3), for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }

    private func setupViews() {
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        setupConstraints()
    }
    
    private func setupConstraints() {
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button2.centerYAnchor.constraint(equalTo: centerYAnchor),
            button2.centerXAnchor.constraint(equalTo: centerXAnchor),
            button2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button2.heightAnchor.constraint(equalToConstant: 44),
            
            button1.bottomAnchor.constraint(equalTo: button2.topAnchor, constant: -20),
            button1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button1.heightAnchor.constraint(equalToConstant: 44),
            
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20),
            button3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button3.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

private extension ThemeView {
    @objc func tap1() {
        Theme.currentTheme = StandartTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
        ThemeSaver.putData()
    }
    
    @objc func tap2() {
        Theme.currentTheme = PurpleTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
        ThemeSaver.putData()
    }
    
    @objc func tap3() {
        Theme.currentTheme = PeachTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
        ThemeSaver.putData()
    }
}
