import Foundation

enum Neighborhood{
    case southLoop
    case loganSquare
}

class NeighborhoodGuidessViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var restaurants: [Business] = []
    private let service = JsonBinAPIService()
    
    func selected(_ neighborhood: Neighborhood) {
        switch neighborhood {
        case .southLoop:
            title = "South Loop"
            description = southLoopText
        case .loganSquare:
            title = "Logan Square"
            description = loganSquareText
        }
    }
    
    func getData(category: String) {
        service.fetchBusinesses(category: category) {businesses in
            DispatchQueue.main.async {
                self.restaurants = businesses
            }
        }
    }
}

let southLoopText = "It’s home to the lakefront Museum Campus, where you’ll find three of Chicago’s biggest museums. Also in the South Loop, you’ll find celebrated jazz clubs, a mix of crowd-pleasing restaurants, and vibrant historic areas like industrial Motor Row and charming the Prairie Avenue District."
let loganSquareText = "Logan Square is a thriving, multi-cultural community of arts organizations, intimate music venues, locally owned shops, trendy cocktail bars, and beyond. Its creative energy and urban vibe make it a go-to for locals looking for the next cool thing."
