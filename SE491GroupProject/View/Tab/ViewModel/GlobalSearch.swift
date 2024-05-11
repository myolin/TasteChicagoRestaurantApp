import Foundation

class GlobalSearch: ObservableObject {
    
    @Published var recommended: [Business] = []
    @Published var american: [Business] = []
    @Published var chinese: [Business] = []
    @Published var korean: [Business] = []
    @Published var japanese: [Business] = []
    @Published var mexican: [Business] = []
    @Published var indian: [Business] = []
    @Published var thai: [Business] = []
    @Published var vietnamese: [Business] = []
    
    @Published var allRestaurants: [Business] = []
    
    let service = JsonBinAPIService()
    
    init() {
        DispatchQueue.main.async { @MainActor in
            self.initializeRecommended()
        }
        DispatchQueue.global(qos: .background).async {
            self.initializeAmerican()
            self.initializeChinese()
            self.initializeKorean()
            self.initializeJapanese()
        }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            self.initializeMexican()
            self.initializeIndian()
            self.initializeThai()
            self.initializeVietnamese()
        }
    }
    
    func initializeRecommended() {
            service.fetchBusinesses(category: "recommended") {businesses in
                DispatchQueue.main.async {
                    self.recommended = businesses
                }
            }
    }
    
    func initializeAmerican() {
        service.fetchBusinesses(category: "American") {businesses in
            DispatchQueue.main.async {
                self.american = businesses
            }
        }
    }
    
    func initializeChinese() {
        service.fetchBusinesses(category: "Chinese") {businesses in
            DispatchQueue.main.async {
                self.chinese = businesses
            }
        }
    }
    
    func initializeKorean() {
        service.fetchBusinesses(category: "Korean") {businesses in
            DispatchQueue.main.async {
                self.korean = businesses
            }
        }
    }
    
    func initializeJapanese() {
        service.fetchBusinesses(category: "Japanese") {businesses in
            DispatchQueue.main.async {
                self.japanese = businesses
            }
        }
    }
    
    func initializeMexican() {
        service.fetchBusinesses(category: "Mexican") {businesses in
            DispatchQueue.main.async {
                self.mexican = businesses
            }
        }
    }
    
    func initializeIndian() {
        service.fetchBusinesses(category: "Indian") {businesses in
            DispatchQueue.main.async {
                self.indian = businesses
            }
        }
    }
    
    func initializeThai() {
        service.fetchBusinesses(category: "Thai") {businesses in
            DispatchQueue.main.async {
                self.thai = businesses
            }
        }
    }
    
    func initializeVietnamese() {
        service.fetchBusinesses(category: "Vietnamese") {businesses in
            DispatchQueue.main.async {
                self.vietnamese = businesses
            }
        }
    }
    
    func combine(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.allRestaurants += (self.american + self.chinese + self.korean + self.japanese + self.mexican + self.indian + self.thai + self.vietnamese)
            print(self.allRestaurants.count)
        }
    }
    
}
