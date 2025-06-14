@testable import hw1_project1

final class NetworkServiceTests: NetworkServiceProtocol {
    var resultToReturn: Result<[Friend], Error>?

    func getFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        if let result = resultToReturn {
            completion(result)
        }
    }
    
    func getGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        completion(.success([]))
    }
    
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        completion([])
    }
}


