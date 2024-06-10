import XCTest
import SwiftUI
import FirebaseCore
@testable import SE491GroupProject

final class SE491GroupProjectTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // test User Model
    func testUserModel_canCreateInstance() {
        let instance = User(id: "Unique ID", fullname: "John Smith", email: "johnsmith@test.com")
        XCTAssertNotNil(instance)
    }

    // test api call, response and restaurant data model
    func testJsonBinAPICalls() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "MockData", withExtension: "json") else {
            XCTFail("Missing file: MockData.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        let restaurant = try decoder.decode(Business.self, from: json)
        
        XCTAssertNotNil(restaurant)
        XCTAssertEqual(restaurant.name, "The Dearborn")
        XCTAssertEqual(restaurant.phone, "(312) 384-1242")
        XCTAssertEqual(restaurant.price, "$$")
        XCTAssertEqual(restaurant.coordinates.latitude, 41.8842528)
        XCTAssertEqual(restaurant.coordinates.longitude, -87.6293151)
        XCTAssertEqual(restaurant.categories, "American")
        XCTAssertEqual(restaurant.address.display_address, ["145 N Dearborn St", "Chicago, IL 60602"])
        XCTAssertEqual(restaurant.menu.menu_url, "https://www.thedearborntavern.com/menu/")
    }
    func testJsonBinAPIService_fetchesDataSuccessfully() {
        let expectation = XCTestExpectation(description: "Fetch restaurants from JSONBin")
        let service = JsonBinAPIService()
        service.fetchBusinesses(category: "Japanese") { restaurants in
            XCTAssertNotNil(restaurants)
            XCTAssert(restaurants.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testYelpAPIService_checksIsOpenNow() {
        let expectation = XCTestExpectation(description: "Check if restaurant is open now")
        let service = YelpAPIService()
        service.getIsOpenNow(restaurant_id: "xFBQ1md6PDm7YEpJARoxAA") { isOpenNow in
            XCTAssertNotNil(isOpenNow)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAppInitialization_configuresFirebase() {
        let isAlreadyConfigured = FirebaseApp.app() != nil
        if !isAlreadyConfigured {
            FirebaseApp.configure()
        }
        XCTAssertTrue(isAlreadyConfigured || FirebaseApp.app() != nil)
    }
    
    func testContentView_defaultTabIsHome() {
        let contentView = ContentView()
        XCTAssertEqual(contentView.selectedTab, .home)
    }
    
    func testRestaurantModel() {
        let coordinate = Coordinate(latitude: 41.8842528, longitude: -87.6293151)
        let address = Address(display_address: ["145 N Dearborn St", "Chicago, IL 60602"])
        let menu = Menu(menu_url: "https://www.example.com/menu")
        let hours = [Hour(hourOpen: [], isOpenNow: true)]
        let restaurant = Business(id: "1", alias: "test-alias", name: "Test Restaurant", image_url: "https://example.com/image.jpg", yelp_url: "https://example.com", phone: "(312) 555-5555", categories: "Test Category", coordinates: coordinate, rating: 4.5, address: address, price: "$$", menu: menu, hours: hours)
        
        XCTAssertNotNil(restaurant)
        XCTAssertEqual(restaurant.name, "Test Restaurant")
    }
    
    func testContentView_changesTab() {
        let contentView = ContentView()
        contentView.selectedTab = .favorite
        XCTAssertNotEqual(contentView.selectedTab, .favorite)
        XCTAssertEqual(contentView.selectedTab, .home)
    }
    
    func testRestaurantCellView_Initialization() {
        let coordinate = Coordinate(latitude: 41.8842528, longitude: -87.6293151)
        let address = Address(display_address: ["145 N Dearborn St", "Chicago, IL 60602"])
        let menu = Menu(menu_url: "https://www.example.com/menu")
        let hours = [Hour(hourOpen: [], isOpenNow: true)]
        let restaurant = Business(id: "1", alias: "test-alias", name: "Test Restaurant", image_url: "https://example.com/image.jpg", yelp_url: "https://example.com", phone: "(312) 555-5555", categories: "Test Category", coordinates: coordinate, rating: 4.5, address: address, price: "$$", menu: menu, hours: hours)

        let view = RestaurantCellView(restaurant: restaurant)
        XCTAssertNotNil(view)
        XCTAssertEqual(view.restaurant.name, "Test Restaurant")
        XCTAssertEqual(view.restaurant.categories, "Test Category")
        XCTAssertEqual(view.restaurant.price, "$$")
    }
    
    @MainActor func testAuthViewModel_signOut() {
        let viewModel = AuthViewModel()
        let expectation = XCTestExpectation(description: "Sign out")

        viewModel.signOut()
        XCTAssertNil(viewModel.userSession)
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
}
