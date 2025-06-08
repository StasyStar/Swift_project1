import UIKit

final class GroupsViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Group] = []
    private var themeView = ThemeView()
    private var fileCache = FileCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = fileCache.fetchGroups()
        tableView.reloadData()
        title = "Groups"
        themeView.delegate = self
        setupTableView()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getGroups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
    }
    
    private func setupAppearance() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.separatorColor = Theme.currentTheme.textColor.withAlphaComponent(0.3)
        
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Theme.currentTheme.textColor]
    }
    
    private func setupTableView() {
        tableView.register(CustomGroupViewCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.separatorColor = Theme.currentTheme.cellBackgroundColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? CustomGroupViewCell else {
            return UITableViewCell()
        }
        cell.updateCell(model: models[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func getGroups() {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.models = groups
                self?.fileCache.addGroups(groups: groups)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchGroups() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
}

extension GroupsViewController: ThemeViewDelegate {
    func updateColor() {
        setupAppearance()
        tableView.reloadData()
    }
    
    @objc func update() {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.models = groups
                self?.fileCache.addGroups(groups: groups)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchGroups() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}

private extension GroupsViewController {
    func showAlert() {
        let date = DateHelper.getDate(date: fileCache.fetchGroupDate())
        let alert = UIAlertController(title: "Не удалось получить данные", message: "Данные актуальны на \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

