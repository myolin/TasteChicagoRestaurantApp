import Foundation

// MARK: - SearchResult

struct SearchResult: Codable {
    let businesses: [Business]
}

// MARK: - Business

struct Business: Codable {
    let rating: Double?
    let price, phone, id, alias: String?
    let isClosed: Bool?
    let name: String?
}
