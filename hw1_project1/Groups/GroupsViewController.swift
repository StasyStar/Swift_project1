import UIKit

final class GroupsViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        setupAppearance()
        setupTableView()
        loadGroups()
    }
    
    private func setupAppearance() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.barTintColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
    }
    
    private func setupTableView() {
        tableView.register(CustomGroupViewCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.separatorColor = Theme.currentTheme.cellBackgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    private func loadGroups() {
        networkService.getGroups { [weak self] groups in
            self?.models = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
}
