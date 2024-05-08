import Foundation

class ListViewModel: ObservableObject {
    @Published var businesses: [Business] = []
    let service = JsonBinAPIService()
    let yelpService = YelpAPIService()
    
    init(_ category: String) {
        getData(category: category)
    }
    
    // Get a list of restaruant in a cuisine and display it in associated ListView
    func getData(category: String) {
        service.fetchBusinesses(category: category) {businesses in
            DispatchQueue.main.async {
                self.businesses = businesses
            }
        }
    }
}
