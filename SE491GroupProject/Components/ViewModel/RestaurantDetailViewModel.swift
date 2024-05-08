import Foundation

class RestaurantDetailViewModel: ObservableObject {
    
    let yelpService = YelpAPIService()
    let firestoreService = FirestoreService()
    @Published var isOpenNow = false
    
    init() {}
    
    func getIsOpenNow(_ id: String) {
        yelpService.getIsOpenNow(restaurant_id: id) { status in
            DispatchQueue.main.async {
                self.isOpenNow = status
            }
        }
    }
    
    // Get all 7 days open hours of a restaurant
    func getOpenHours(_ open: [Hour]) -> String{
        var hours: String = ""
        
        if let hourArray = open.first?.hourOpen {
            for hour in hourArray {
                switch hour.day {
                case 0:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Mon  \(start) - \(end)\n"
                case 1:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Tue  \(start) - \(end)\n"
                case 2:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Wed  \(start) - \(end)\n"
                case 3:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Thur  \(start) - \(end)\n"
                case 4:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Fri  \(start) - \(end)\n"
                case 5:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Sat  \(start) - \(end)\n"
                case 6:
                    let start = formatTime(hour.start)
                    let end = formatTime(hour.end)
                    hours += "Sun  \(start) - \(end)\n"
                default:
                    hours += "Closed\n"
                }
            }
        }
        return hours
    }
    
    // Format time to "HH:mm am/pm" format
    func formatTime(_ rawTime: String) -> String{
        var formattedTime = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        let time = dateFormatter.date(from: rawTime)
        
        dateFormatter.dateFormat = "hh:mm a"
        if let time = time {
            formattedTime = dateFormatter.string(from: time)
        }
        return formattedTime
    }
    
    // Add user favorite restaurant to Firestore
    func addToFav(_ restaurant: Business) {
        firestoreService.addToUserFavRestaurant(restaurant)
    }
    
}
