import Foundation

final class NetworkService {
    private let session = URLSession.shared
    private let url = URL(string: "https://raw.githubusercontent.com/StasyStar/Swift_project2/main/hw1_project2/sem3.json")
    
    func getFriends(completion: @escaping ([Friend]) -> Void) {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                completion(root.friends.items)
                print("Friends: \(root.friends.items)")
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                completion(root.groups.items)
                print("Groups: \(root.groups.items)")
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                completion(root.photos.items)
                print("Photos: \(root.photos.items)")
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}
