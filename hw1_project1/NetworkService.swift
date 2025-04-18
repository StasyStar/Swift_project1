import Foundation

final class NetworkService {
    private let session = URLSession.shared
    private let url = URL(string: "https://raw.githubusercontent.com/StasyStar/Swift_project2/main/hw1_project2/sem3.json")
    
    func getFriends() {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                print("\n=== Friends ===")
                print("Count: \(root.friends.count)")
                root.friends.items.forEach { friend in
                    print("""
                    ID: \(friend.id)
                    Name: \(friend.firstName) \(friend.lastName)
                    Photo: \(friend.photo100)
                    Online: \(friend.online == 1 ? "Yes" : "No")
                    """)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    func getGroups() {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                print("\n=== Groups ===")
                print("Count: \(root.groups.count)")
                root.groups.items.forEach { group in
                    print("""
                    ID: \(group.id)
                    Name: \(group.name)
                    Screen Name: \(group.screenName)
                    Photo: \(group.photo100)
                    Members: \(group.membersCount)
                    """)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    func getPhotos() {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                print("\n=== Photos ===")
                print("Count: \(root.photos.count)")
                root.photos.items.forEach { photo in
                    let largestSize = photo.sizes.max(by: { $0.width < $1.width })
                    print("""
                    ID: \(photo.id)
                    Album ID: \(photo.albumId)
                    Owner ID: \(photo.ownerId)
                    Text: \(photo.text)
                    Date: \(Date(timeIntervalSince1970: TimeInterval(photo.date)))
                    Likes: \(photo.likes.count)
                    Largest Size: \(largestSize?.url ?? "N/A") (\(largestSize?.width ?? 0)x\(largestSize?.height ?? 0))
                    """)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}
