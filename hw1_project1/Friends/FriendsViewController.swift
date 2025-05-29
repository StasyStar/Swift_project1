import UIKit

final class FriendsViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Friend] = []
    private var themeView = ThemeView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        tableView.reloadData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(tap))
        
        tableView.register(CustomFriendViewCell.self, forCellReuseIdentifier: "FriendCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        
        networkService.getFriends { [weak self] friends in
            self?.models = friends
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        view.backgroundColor = Theme.currentTheme.backgroundColor
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { models.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? CustomFriendViewCell else {
            return UITableViewCell()
        }
        let friendName = models[indexPath.row]
        cell.updateCell(model: friendName)
        return cell
    }
}

private extension FriendsViewController {
    @objc func tap() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.type = .moveIn
        animation.duration = 3
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(), animated: false)
    }
}
