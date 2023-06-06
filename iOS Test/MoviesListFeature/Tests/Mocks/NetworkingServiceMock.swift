import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

class NetworkingServiceMock: NetworkingType {
    var requestCallsCount = 0
    var requestResult: Result<MoviesListResource.Response, NetworkError> = .success([Movie.stub()])

    func request<R: ResourceType>(_ resource: R) async -> Result<R.Response, NetworkError> {
        requestCallsCount += 1
        return requestResult as! Result<R.Response, NetworkError>
    }
}
