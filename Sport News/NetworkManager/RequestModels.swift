
import Foundation

//News Details By ID
struct NewsModelDetails: Codable {
    let id, liked, angry, sad: Int
    let source: Source
    let commented: Int
    let isFavourites: Bool
    let favouriteID: Int?
    let header, text: String
    let image: String
    let video: String
    let shared: Int
    let sourceUniqueID, link: String
    let breaking: Bool
    let createdAt: String
    let likeCount, sadCount, angryCount: Int

    enum CodingKeys: String, CodingKey {
        case id, liked, angry, sad, source, commented
        case isFavourites = "is_favourites"
        case favouriteID = "favourite_id"
        case header, text, image, video, shared
        case sourceUniqueID = "source_unique_id"
        case link, breaking
        case createdAt = "created_at"
        case likeCount = "like_count"
        case sadCount = "sad_count"
        case angryCount = "angry_count"
    }

    // MARK: - Source
    struct Source: Codable {
        let id: Int
        let category: Category
        let mainSource: String?
        let followerCount: Int
        let title: String
        let subtitle: String?
        let image: String?
        let region, city: String
        let originalURL: String?
        let isHidden: Bool

        enum CodingKeys: String, CodingKey {
            case id, category
            case mainSource = "main_source"
            case followerCount = "follower_count"
            case title, subtitle, image, region, city
            case originalURL = "original_url"
            case isHidden = "is_hidden"
        }

        // MARK: - Category
        struct Category: Codable {
            let id: Int
            let title: String
            let subtitle: String?
            let image: String?
        }
    }
}
//------------------------------------------------------------//




// MARK: - Category
struct Categories: Codable {
    let id: Int
    let title: String
    let subtitle: JSONNull?
    let image: String?
}

// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//            return true
//    }
//
//    public var hashValue: Int {
//            return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//            let container = try decoder.singleValueContainer()
//            if !container.decodeNil() {
//                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//            }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//            var container = encoder.singleValueContainer()
//            try container.encodeNil()
//    }
//}
//
//
//
//
//  Two versions of NewsModel including NULL able elements
//struct NewsModel: Decodable {
//    
//    let id: Int
//    let angry: Int
//    let breaking: Int
//    let commented: Int
//    let header: String
//    let image: String
//    let liked: Int
//    let link: String
//    let shared: Int
//    let source: Source
//    let text: String
//    let video: String
//    let created_at: String
//
//    enum CodingKeys: String, CodingKey {
//        
//        case id
//        case angry
//        case breaking
//        case commented
//        case header
//        case image
//        case liked
//        case link
//        case shared
//        case source
//        case text
//        case video
//        case created_at
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        angry = try container.decodeConvertibleValue(Int.self, forKey: .angry)
//        breaking = try container.decodeConvertibleValue(Int.self, forKey: .breaking)
//        commented = try container.decodeConvertibleValue(Int.self, forKey: .commented)
//        header = try container.decode(String.self, forKey: .header)
//        image = try container.decode(String.self, forKey: .image)
//        liked = try container.decodeConvertibleValue(Int.self, forKey: .liked)
//        link = try container.decode(String.self, forKey: .link)
//        shared = try container.decodeConvertibleValue(Int.self, forKey: .shared)
//        source = try container.decode(Source.self, forKey: .source)
//        text = try container.decode(String.self, forKey: .text)
//        video = try container.decode(String.self, forKey: .video)
//        created_at = try container.decode(String.self, forKey: .created_at)
//    }
//}
//
//
//struct Source: Decodable {
//    let city: String
//    let id: Int
//    let image: String?
//    let region: String?
//    let subtitle: String?
//    let title: String
//
//    enum CodingKeys: String, CodingKey {
//        case city
//        case id
//        case image
//        case region
//        case subtitle
//        case title
//    }
//}

struct NewsModel: Codable {
    let id, liked, angry, sad: Int
    let source: Source
    let commented: Int
    let isFavourites: Bool
    let header, text: String
    let image: String
    let video: String
    let shared: Int
    let sourceUniqueID, link: String
    let breaking: Bool
    let createdAt: String
    let likeCount, sadCount, angryCount: Int

    enum CodingKeys: String, CodingKey {
        case id, liked, angry, sad, source, commented
        case isFavourites = "is_favourites"
        case header, text, image, video, shared
        case sourceUniqueID = "source_unique_id"
        case link, breaking
        case createdAt = "created_at"
        case likeCount = "like_count"
        case sadCount = "sad_count"
        case angryCount = "angry_count"
    }
}

// MARK: - Source
struct Source: Codable {
    let id: Int
    let mainSource: JSONNull?
    let title: String
    let subtitle, image: JSONNull?
    let region, city: String
    let originalURL: JSONNull?
    let isHidden: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case mainSource = "main_source"
        case title, subtitle, image, region, city
        case originalURL = "original_url"
        case isHidden = "is_hidden"
    }
}


typealias Welcome = [NewsModel]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}


extension KeyedDecodingContainer {
    func decodeConvertibleValue<T: LosslessStringConvertible>(_ type: T.Type, forKey key: Key) throws -> T {
        if let intValue = try? decode(Int.self, forKey: key) {
            return T(String(intValue))!
        } else if let boolValue = try? decode(Bool.self, forKey: key) {
            return T(boolValue ? "1" : "0")!
        } else if let stringValue = try? decode(String.self, forKey: key), let convertedValue = T(stringValue) {
            return convertedValue
        } else {
            throw DecodingError.typeMismatch(T.self, DecodingError.Context(codingPath: [key], debugDescription: "Expected to decode \(T.self) but found different type"))
        }
    }
}
//-----------------------------------------------------------------//



// Categories model

struct CategoriesModel: Codable {
    let id: Int
    let image: String
    let title: String
    var followed_by_user: Bool
}


//Add favorite category by ID
struct addFavourite: Codable {
    let id: Int
}

// Add favorite results Models
struct SuccessFavourite: Codable {
    let result: String
}



//Registrtion Request Model
struct RegistrationRequest: Codable {
    let username: String
    let email: String
    let country: String
    let password: String
    let sex: Int
    let year_of_birth: Int
    let gclid: String
    let city: String
}

// SignIn/SignUP response Model
struct AuthModel: Codable {
    let profile: Profile
    let access_token: String
    let refresh_token: String
}


// SignIn SignUp request model
struct Profile: Codable {
    let id: Int
    let username: String
    let email: String
    let city: String
    let sex: Int?
    let year_of_birth: Int?
    let country: String?
    let gclid: String?
}


// Change password request model
struct PasswordChange: Codable {
    let old_password: String
    let new_password: String
}


//SignUp request model
struct SignUpModel: Codable {
    struct Result: Codable {
        
        let profile: Profile
        let accessToken, refreshToken: String

        enum CodingKeys: String, CodingKey {
            case profile
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
        }
    }

    // MARK: - Profile
    struct Profile: Codable {
        let id: Int
        let username, email, city: String
        let sex, yearOfBirth: Int
        let country, gclid: String

        enum CodingKeys: String, CodingKey {
            case id, username, email, city, sex
            case yearOfBirth = "year_of_birth"
            case country, gclid
        }
    }
}



// News Comment Response Model
struct NewsCommentByIDModel: Codable {
    let count: Int
    let next, previous: String
    let results: [Result]
    
    
    struct Result: Codable {
        let id: Int
        let author: Author
        let text: String
        let news: Int
        let comment: String
        let liked: Int
        let likedByUser: Bool
        let commented: Int
        let createdAt: String
        let childComments: [ChildComment]
        
        enum CodingKeys: String, CodingKey {
            case id, author, text, news, comment, liked
            case likedByUser = "liked_by_user"
            case commented
            case createdAt = "created_at"
            case childComments = "child_comments"
        }
    }
    
    // MARK: - Author
    struct Author: Codable {
        let id: Int
        let username, photo, city: String
        let sex, yearOfBirth: Int
        
        enum CodingKeys: String, CodingKey {
            case id, username, photo, city, sex
            case yearOfBirth = "year_of_birth"
        }
    }
    
    // MARK: - ChildComment
    struct ChildComment: Codable {
        let id: Int
        let author: Author
        let text: String
        let liked: Int
        let likedByUser: Bool
        let createdAt: String
        
        enum CodingKeys: String, CodingKey {
            case id, author, text, liked
            case likedByUser = "liked_by_user"
            case createdAt = "created_at"
        }
    }
    
}




