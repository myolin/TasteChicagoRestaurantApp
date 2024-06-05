import Foundation

class CalendarSpecificViewModel: ObservableObject {
    @Published var restaurants: [Business] = []
    private let service = JsonBinAPIService()
    
    func getData(category: String) {
        service.fetchBusinesses(category: category) {businesses in
            DispatchQueue.main.async {
                self.restaurants = businesses
            }
        }
    }
}
