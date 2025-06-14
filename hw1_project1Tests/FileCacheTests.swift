import Foundation
@testable import hw1_project1

final class FileCacheTests: FileCacheProtocol {
    var friendsToReturn: [Friend] = []
    var addFriendsCalled = false
    
    func fetchFriends() -> [Friend] {
        return friendsToReturn
    }
    
    func addFriends(friends: [Friend]) {
        addFriendsCalled = true
        friendsToReturn = friends
    }
    
    func fetchFriendDate() -> Date? {
        return Date(timeIntervalSince1970: 0)
    }
}


