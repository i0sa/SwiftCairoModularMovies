import XCTest
@testable import ConsumerNetworking
import SwiftCairoCommon

class RequestBuilderMock: RequestBuilderType {
    var shouldThrowError = false
    func createURLRequest<R: ResourceType>(for resource: R) throws -> URLRequest {
        if shouldThrowError {
            throw TestError.requestBuilderError
        }
        return URLRequest(url: URL(string: "https://example.com")!)
    }
}
