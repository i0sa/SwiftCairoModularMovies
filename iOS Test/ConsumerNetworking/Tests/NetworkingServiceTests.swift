import XCTest
@testable import ConsumerNetworking
import SwiftCairoCommon

class NetworkingServiceTests: XCTestCase {
    private var sut: NetworkingService!

    private var requestBuilderMock: RequestBuilderMock!
    private var urlSessionMock: URLSessionMock!

    override func setUp() {
        super.setUp()
        requestBuilderMock = RequestBuilderMock()
        urlSessionMock = URLSessionMock()
        sut = NetworkingService(requestBuilder: requestBuilderMock, urlSession: urlSessionMock)
    }

    override func tearDown() {
        requestBuilderMock = nil
        urlSessionMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testRequestReturnsSuccess_When_RequestSucceeds() async {
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "https://swiftcairo.com")!,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        urlSessionMock.data = Data()
        let resource = TestResource.stub()
        let result = await sut.request(resource)

        XCTAssertResultSuccess(result)
    }

    func testRequest_ParsesResponse_Correctly_When_RequestSucceeds() async {
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        urlSessionMock.data = Data()
        let expectedParseValue = "VALUE THAT GOT PARSED"
        let resource = TestResource.stub(parseValue: expectedParseValue)
        let result = await sut.request(resource)

        XCTAssertResultSuccess(result) { parsedData in
            XCTAssertEqual(parsedData, expectedParseValue)
        }
    }

    
    func test_RequestReturnsInvalidRequestError_When_RequestBuilder_ThrowsError() async {
        requestBuilderMock.shouldThrowError = true
        let resource = TestResource.stub()
        let result = await sut.request(resource)

        XCTAssertResultFailure(result) { error in
            XCTAssertEqual(error, .invalidRequest)
        }
    }

    func test_RequestReturnsServerError_When_StatusCode_Not200() async {
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "https://swiftcairo.com")!,
                                                  statusCode: 500,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        urlSessionMock.data = Data("Fake response".utf8)
        let resource = TestResource.stub()
        let result = await sut.request(resource)

        XCTAssertResultFailure(result) { error in
            XCTAssertEqual(error, .serverError)
        }
    }

    func testRequestReturnsNetworkError_When_URLSession_ThrowsError() async {
        urlSessionMock.shouldThrowError = true
        let resource = TestResource.stub()
        let result = await sut.request(resource)

        XCTAssertResultFailure(result) { error in
            XCTAssertEqual(error, .networkError)
        }
    }
}
