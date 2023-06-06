import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

class SwiftCairoCacheServiceMock: SwiftCairoCache {
    var saveCallsCount = 0
    var fetchCallsCount = 0
    var cache: [String: Data] = [:]
    
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        saveCallsCount += 1
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        cache[key] = data
    }
    
    func fetch<T: Codable>(forKey key: String) throws -> T {
        fetchCallsCount += 1
        let decoder = JSONDecoder()
        if let data = cache[key] {
            return try decoder.decode(T.self, from: data)
        }
        throw SwiftCairoCacheError.noData
    }
}
enum SwiftCairoCacheError: Error {
    case noData
}
