struct PhotosModel: Decodable {
    let count: Int
    let items: [Photo]
}

struct Photo: Decodable {
    let id: Int
    let albumId: Int
    let ownerId: Int
    let url: String  // Теперь url прямо в объекте Photo
    let width: Int
    let height: Int
    let text: String
    let date: Int
    let likes: PhotoLikes
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case url
        case width
        case height
        case text
        case date
        case likes
    }
}

struct PhotoLikes: Decodable {
    let count: Int
}
