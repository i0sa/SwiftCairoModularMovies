import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

class MoviesListWorkerTests: XCTestCase {
    var sut: MoviesListWorker!
    var networkingServiceMock: NetworkingServiceMock!
    var swiftCairoCacheServiceMock: SwiftCairoCacheServiceMock!
    
    override func setUpWithError() throws {
        networkingServiceMock = NetworkingServiceMock()
        swiftCairoCacheServiceMock = SwiftCairoCacheServiceMock()
        sut = MoviesListWorker(networkService: networkingServiceMock,
                                cachingService: swiftCairoCacheServiceMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkingServiceMock = nil
        swiftCairoCacheServiceMock = nil
    }

    func test_fetchMoviesList_CachingEnabled() async {
        // Given
        let expectedMovies = [Movie.stub()]
        networkingServiceMock.requestResult = .success(expectedMovies)
        
        // When
        let result = await sut.fetchMoviesList()
        
        // Then
        XCTAssertEqual(networkingServiceMock.requestCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.saveCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.fetchCallsCount, 1)
        
        XCTAssertResultSuccess(result) { movies in
            XCTAssertEqual(movies, expectedMovies)
        }
    }

    func test_fetchMoviesList_CachingEnabled_And_Consumes_Cache_Without_Calling_Network() async throws {
        // Given
        let expectedMovies = [Movie.stub()]
        networkingServiceMock.requestResult = .success(expectedMovies)
        
        // When
        _ = await sut.fetchMoviesList()
        // Then
        // Validate that fetch is called once, while network call was only called once, at first time - as well as saving
        XCTAssertEqual(networkingServiceMock.requestCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.saveCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.fetchCallsCount, 1)

        // When second time call
        let result = await sut.fetchMoviesList()
        
        // Then
        // Validate that fetch is called twice, while network call was only called once, at first time - as well as saving
        XCTAssertEqual(networkingServiceMock.requestCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.saveCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.fetchCallsCount, 2)
        
        let cache: [Movie] = try swiftCairoCacheServiceMock.fetch(forKey: "movies")
        
        XCTAssertResultSuccess(result) { movies in
            XCTAssertEqual(movies, cache)
        }
    }
    
    func test_fetchMoviesList_CachingDisabled() async {
        // Given
        sut = MoviesListWorker(networkService: networkingServiceMock,
                                cachingService: swiftCairoCacheServiceMock,
                                cachingEnabled: false)
        let expectedMovies = [Movie.stub()]
        networkingServiceMock.requestResult = .success(expectedMovies)
        
        // When
        let result = await sut.fetchMoviesList()
        
        // Then
        XCTAssertEqual(networkingServiceMock.requestCallsCount, 1)
        XCTAssertEqual(swiftCairoCacheServiceMock.saveCallsCount, 0)
        XCTAssertEqual(swiftCairoCacheServiceMock.fetchCallsCount, 0)
        
        XCTAssertResultSuccess(result) { movies in
            XCTAssertEqual(movies, expectedMovies)
        }
    }
}
