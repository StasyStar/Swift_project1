import UIKit

final class FriendsViewController: UITableViewController {
    private let networkService: NetworkServiceProtocol
    private var fileCache: FileCacheProtocol
    var presentAlertHandler: ((UIAlertController) -> Void)?
    var models: [Friend] = []
    private var themeView = ThemeView()

    init(networkService: NetworkServiceProtocol = NetworkService(), fileCache: FileCacheProtocol = FileCache()) {
        self.networkService = networkService
        self.fileCache = fileCache
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getFriends()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
    }

    private func setupUI() {
        models = fileCache.fetchFriends()
        tableView.reloadData()
        title = "Friends"
        
        themeView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            style: .plain,
            target: self,
            action: #selector(tap)
        )

        tableView.register(CustomFriendViewCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupAppearance() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.separatorColor = Theme.currentTheme.textColor.withAlphaComponent(0.3)

        navigationController?.navigationBar.barTintColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.textColor]
    }

    func getFriends() {
        networkService.getFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.models = friends
                self.fileCache.addFriends(friends: friends)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                self.models = self.fileCache.fetchFriends()
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = models[indexPath.row]
        let profileVC = ProfileViewController(friend: selectedFriend)
        navigationController?.pushViewController(profileVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? CustomFriendViewCell else {
            return UITableViewCell()
        }
        let friend = models[indexPath.row]
        cell.updateCell(model: friend)
        return cell
    }
}

extension FriendsViewController: ThemeViewDelegate {
    func updateColor() {
        setupAppearance()
        tableView.reloadData()
    }

    @objc func tap() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.type = .moveIn
        animation.duration = 3
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(), animated: false)
    }

    @objc func update() {
        networkService.getFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.models = friends
                self.fileCache.addFriends(friends: friends)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                self.models = self.fileCache.fetchFriends()
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
        }
    }
}

private extension FriendsViewController {
    func showAlert() {
        let date = DateHelper.getDate(date: fileCache.fetchFriendDate())
        let alert = UIAlertController(title: "Не удалось получить данные", message: "Данные актуальны на \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        presentAlertHandler?(alert)
        present(alert, animated: true, completion: nil)
    }
}
