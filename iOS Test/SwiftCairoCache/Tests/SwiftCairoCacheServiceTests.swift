import XCTest
@testable import SwiftCairoCache
import SwiftCairoCommon

class SwiftCairoCacheServiceTests: XCTestCase {
    var sut: SwiftCairoCacheService!

    override func setUpWithError() throws {
        self.sut = SwiftCairoCacheService(serviceName: "Test")
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSaveAndFetch() throws {
        let testObject = TestObject(id: "1")
        try sut.save(testObject, forKey: "key")
        
        let decoded: TestObject = try sut.fetch(forKey: "key")
        
        XCTAssertEqual(decoded, testObject)
    }
    
    func testCacheService_Using_Correct_UserDefaults_Suite_From_ServiceName() throws {
        let serviceName = "MoviesListFeature"
        self.sut = SwiftCairoCacheService(serviceName: serviceName)
        let testObject = TestObject(id: "1")
        try sut.save(testObject, forKey: "key")
        
        let serviceUserDefaults = UserDefaults(suiteName: serviceName)
        let valueExists = serviceUserDefaults?.value(forKey: "key") != nil
        
        XCTAssertTrue(valueExists)
    }
}

struct TestObject: Codable, Equatable {
    let id: String
}
