import Foundation

final class ThemeSaver {
    private static let key = "selectedTheme"

    enum ThemeType: String {
        case standard
        case purple
        case peach
    }

    static func putData() {
        let themeType: ThemeType

        switch Theme.currentTheme {
        case is StandartTheme:
            themeType = .standard
        case is PurpleTheme:
            themeType = .purple
        case is PeachTheme:
            themeType = .peach
        default:
            themeType = .standard
        }
        UserDefaults.standard.set(themeType.rawValue, forKey: key)
    }

    static func loadData() {
        guard let savedTheme = UserDefaults.standard.string(forKey: key),
              let themeType = ThemeType(rawValue: savedTheme) else {
            Theme.currentTheme = StandartTheme()
            return
        }
        switch themeType {
        case .standard:
            Theme.currentTheme = StandartTheme()
        case .purple:
            Theme.currentTheme = PurpleTheme()
        case .peach:
            Theme.currentTheme = PeachTheme()
        }
    }
}

