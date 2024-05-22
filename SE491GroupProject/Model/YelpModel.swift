import Foundation

// MARK: - YelpSearchResult

struct YelpSearchResult: Codable {
    let businesses: [YelpModel]
}

// MARK: - YelpModel

struct YelpModel: Codable, Identifiable {
    let id: String
    let name: String
    let yelp_url: String
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case yelp_url = "url"
        case distance
    }
}
