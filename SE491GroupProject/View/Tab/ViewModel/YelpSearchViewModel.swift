import Foundation

class YelpSearchViewModel: ObservableObject, Identifiable {
    
    @Published var searchResults: [YelpModel] = []
    
    private var service = YelpAPIService()
    
    func search(searchTerm: String) {
        service.search(searchTerm: searchTerm) { businesses in
            DispatchQueue.main.async {
                self.searchResults = businesses
            }
        }
    }
}
