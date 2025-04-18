import UIKit

final class FriendsViewController: UITableViewController {
    let friends: [String] = ["Stasy", "Igor", "Ivan", "Marina", "Valentina"]
    private var networkService = NetworkService()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Friends"
        tableView.register(CustomFriendViewCell.self, forCellReuseIdentifier: "FriendCell")
        
        networkService.getFriends()
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { friends.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! CustomFriendViewCell
        
        let friendName = friends[indexPath.row]
        cell.setFriendName(friendName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {70}
}
