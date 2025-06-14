// В проект без сториборд добавить новый экран. На экране должно отображаться 5 ячеек. Раздел всего один. Ячейка должна соответствовать схеме (см. файл по ссылке)
// По клику на кнопку “Войти” переходить к контроллеру из 1 пункта.
// По клику на ячейку из пункта 1 должен быть переход на экран, напоминающий экран переписки. Экран должен быть приближен к схеме.

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViws()
    }
    
    private func setupViws() {
        let tab1 = UINavigationController(rootViewController: FriendsViewController())
        let tab2 = UINavigationController(rootViewController: GroupsViewController())
        let tab3 = UINavigationController(rootViewController: PhotosViewController())
        
        tab1.tabBarItem.title = "Friends"
        tab2.tabBarItem.title = "Groups"
        tab3.tabBarItem.title = "Photos"
                
        let controllers = [tab1, tab2, tab3]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let firstWindow = firstScene.windows.first else { return }
        firstWindow.rootViewController = tabBarController
    }
}
