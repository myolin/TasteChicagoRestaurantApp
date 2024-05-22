import Foundation

class YelpAPIService {
    
    // API KEY from yelp fusion API developer website
    let yelpAPIKey = "Vn_M-fPUCA1yOD0Sr6Cas3t202PQibB9pXxE4VrCE5GzucqOYJJPiPpx45kvzbeXByuUW1xbgeZ1Sfaebl5uPPAn_K7NZXxOCYRXXP2xclLkRJTwBgOd7aMJwuNKZnYx"
    
    //Yelp Base URL for getting a business detail
    let yelpBusinessDetailBaseURL = "https://api.yelp.com/v3/businesses/"
    
    //Yelp Base URL for business search
    let yelpBusinessSearchURL = "https://api.yelp.com/v3/businesses/search"
        
    //check a particular field "isOpenNow" from yelp response
    func getIsOpenNow(restaurant_id: String, completion: @escaping(Bool) -> Void) {
        let url = URL(string: "\(yelpBusinessDetailBaseURL)\(restaurant_id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(yelpAPIKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let jsonData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(YelpHour.self, from: jsonData)
                let hours = decodedData.hours.last
                if let isOpenNow = hours?.isOpenNow {
                    completion(isOpenNow)
                }
            } catch {
                print("ERROR getting IsOpenNow from yelp")
            }
        }.resume()
    }
    
    //broader yelp search with a query term
    func search(searchTerm: String, completion: @escaping([YelpModel]) -> Void) {
        let url = URL(string: yelpBusinessSearchURL)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "location", value: "DePaul University Loop"),
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "sort_by", value: "distance"),
            URLQueryItem(name: "limit", value: "5"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.setValue("Bearer \(yelpAPIKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(YelpSearchResult.self, from: jsonData)
                completion(decodedData.businesses)
            } catch {
                print("ERROR getting yelp search result")
            }
        }.resume()
    }
    
}
