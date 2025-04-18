struct PhotosModel: Decodable {
    let count: Int
    let items: [Photo]
}

struct Photo: Decodable {
    let id: Int
    let albumId: Int
    let ownerId: Int
    let sizes: [PhotoSize]
    let text: String
    let date: Int
    let likes: PhotoLikes
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
        case text
        case date
        case likes
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct PhotoLikes: Decodable {
    let count: Int
}
