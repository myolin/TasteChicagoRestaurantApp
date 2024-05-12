import XCTest
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
}
