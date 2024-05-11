import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var restaurants: [Business] = []
    @Published var filteredRestaurants: [Business] = []
    let service = JsonBinAPIService()
    
    init() {
    }
    
    func getTopRecommendation(_ globalSearch: GlobalSearch) {
        DispatchQueue.main.async {
            self.restaurants = globalSearch.recommended
        }
    }
    
    func combineAll(_ globalSearch: GlobalSearch) {
        globalSearch.combine()
    }
}
