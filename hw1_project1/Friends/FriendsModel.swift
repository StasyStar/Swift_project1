struct FriendsModel: Decodable {
    let count: Int
    let items: [Friend]
}

struct Friend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    let online: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case online
    }
}
