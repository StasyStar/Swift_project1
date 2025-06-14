import Foundation

protocol NetworkServiceProtocol {
    func getFriends(completion: @escaping (Result<[Friend], Error>) -> Void)
    func getGroups(completion: @escaping (Result<[Group], Error>) -> Void)
    func getPhotos(completion: @escaping ([Photo]) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    enum NetworkError: Error {
        case dataError
    }
    private let session = URLSession.shared
    private let url = URL(string: "https://raw.githubusercontent.com/StasyStar/Swift_project2/main/hw1_project2/sem3.json")
    
    func getFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error {
                completion(.failure(error))
                return
            }
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                completion(.success(root.friends.items))
                print("Friends: \(root.friends.items)")
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        session.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error {
                completion(.failure(error))
                return
            }
            do {
                let root = try JSONDecoder().decode(RootModel.self, from: data)
                completion(.success(root.groups.items))
                print("Groups: \(root.groups.items)")
            } catch {
                completion(.failure(NetworkError.dataError))
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
