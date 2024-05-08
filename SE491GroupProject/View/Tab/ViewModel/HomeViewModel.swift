import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var searchTerm = ""
    @Published var restaurants: [Business] = []
    @Published var filteredRestaurants: [Business] = []
    let service = JsonBinAPIService()
    
    init() {
        service.fetchBusinesses(category: "recommended") { businesses in
            DispatchQueue.main.async {
                self.restaurants = businesses
            }
        }
    }
}
