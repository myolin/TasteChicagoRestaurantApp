import Foundation

class JsonBinAPIService {
    
    //JSONBin.io master api key
    let jsonBinAPIKey = "$2a$10$y6DjxCwCEiFgELC6vkxUz.2sKHgTyMLVMCmVpomXYdV4nIWw6rTai"
    
    //Base URL for APIcalls
    let baseURL = "https://api.jsonbin.io/v3/b/"
    
    init() {}
    
    //Fetch all businesses from JSONBin.io bin
    //category - User tap a cuisine from CategoryView
    func fetchBusinesses(category: String, completion: @escaping([Business]) -> Void) {
        let urlString = getURLString(category: category)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.addValue("\(jsonBinAPIKey)", forHTTPHeaderField: "X-Master-Key")
        request.addValue("false", forHTTPHeaderField: "X-Bin-Meta")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(SearchResult.self, from: jsonData)
                completion(decodedData.businesses)
            } catch {
                print("ERROR decoding data")
            }
        }.resume()
    }
    
    //Return bin id for a cuisine
    func getURLString(category: String) -> String {
        switch category {
        case "recommended":
            return "\(baseURL)6632757ead19ca34f8630bac"
        case "American":
            return "\(baseURL)66395227e41b4d34e4efcf9c"
        case "Chinese":
            return "\(baseURL)66395255acd3cb34a843f9f8"
        case "Korean":
            return "\(baseURL)66395278acd3cb34a843fa06"
        case "Japanese":
            return "\(baseURL)66395290ad19ca34f86580c5"
        case "Mexican":
            return "\(baseURL)663952bbacd3cb34a843fa1d"
        case "Indian":
            return "\(baseURL)663952cee41b4d34e4efcfcc"
        case "Thai":
            return "\(baseURL)663ac494e41b4d34e4f05626"
        case "Vietnamese":
            return "\(baseURL)663ac4b8e41b4d34e4f05635"
        default:
            return ""
        }
    }
}
