import Foundation

class YelpAPIService {
    
    // API KEY from yelp fusion API developer website
    let yelpAPIKey = "kLjcVx1divuGvko_iiu13KFmA1RzitV89RkmEBGql5dQ_Frs5pHU2bRHYazFb3XJNnk1KHa4rPT_2MmVKGZi8vCCmnx_5hzVVr9WXBOTadd8fphQ4k5yRrSEjeYiZnYx"
    
    //Yelp Base URL for getting a business detail
    let yelpBusinessDetailBaseURL = "https://api.yelp.com/v3/businesses/"
    
    init() {}
    
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
    
    
}
