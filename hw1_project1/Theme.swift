import UIKit

protocol AppTheme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var buttonColor: UIColor { get }
    var cellBackgroundColor: UIColor { get }
}

final class Theme {
    static var currentTheme: AppTheme = StandartTheme()
}

final class StandartTheme: AppTheme {
    var backgroundColor: UIColor = .lightGray
    var textColor: UIColor = .black
    var buttonColor: UIColor = .darkGray
    var cellBackgroundColor: UIColor = .white
}

final class PurpleTheme: AppTheme {
    var backgroundColor: UIColor = UIColor(red: 40/255, green: 0/255, blue: 60/255, alpha: 1)
    var textColor: UIColor = UIColor(red: 230/255, green: 200/255, blue: 255/255, alpha: 1)
    var buttonColor: UIColor = UIColor(red: 100/255, green: 0/255, blue: 150/255, alpha: 1)
    var cellBackgroundColor: UIColor = UIColor(red: 50/255, green: 0/255, blue: 70/255, alpha: 1)
}

final class PeachTheme: AppTheme {
    var backgroundColor: UIColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
    var textColor: UIColor = .black
    var buttonColor: UIColor = UIColor(red: 255/255, green: 179/255, blue: 128/255, alpha: 1)
    var cellBackgroundColor: UIColor = UIColor(red: 255/255, green: 242/255, blue: 230/255, alpha: 1)
}

