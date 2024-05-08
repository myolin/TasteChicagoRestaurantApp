import Foundation

// MARK: - SearchResult

struct SearchResult: Codable {
    let businesses: [Business]
}

// MARK: - Business

struct Business: Codable, Identifiable {
    let id: String
    let alias: String
    let name: String
    let image_url: String
    let yelp_url: String
    let phone: String
    let categories: String
    let coordinates: Coordinate
    let rating: Double
    let address: Address
    let price: String
    let menu: Menu
    let hours: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case image_url
        case yelp_url = "url"
        case phone = "display_phone"
        case categories
        case coordinates
        case rating
        case address = "location"
        case price
        case menu = "attributes"
        case hours
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct Menu: Codable {
    let menu_url: String
}

struct Address: Codable {
    let display_address: [String]
}

struct Hour: Codable {
    let hourOpen: [Open]
    let isOpenNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case isOpenNow = "is_open_now"
    }
}

struct Open: Codable {
    let start: String
    let end: String
    let day: Int
}

struct YelpHour: Codable {
    let hours: [Hour]
}
