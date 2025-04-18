struct GroupsModel: Decodable {
    let count: Int
    let items: [Group]
}

struct Group: Decodable {
    let id: Int
    let name: String
    let screenName: String
    let photo100: String
    let membersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case photo100 = "photo_100"
        case membersCount = "members_count"
    }
}
