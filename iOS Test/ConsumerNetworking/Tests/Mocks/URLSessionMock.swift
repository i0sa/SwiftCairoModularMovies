import XCTest
@testable import ConsumerNetworking
import SwiftCairoCommon

class URLSessionMock: URLSessionType {
    var data: Data?
    var response: URLResponse?
    var shouldThrowError = false

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if shouldThrowError {
            throw TestError.urlSessionError
        }

        guard let data = data, let response = response else {
            throw TestError.unexpectedNil
        }

        return (data, response)
    }
}

enum TestError: Error {
    case requestBuilderError
    case urlSessionError
    case unexpectedNil
}

