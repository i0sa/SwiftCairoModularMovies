import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

class MoviesListWorkerMock: MoviesListWorkerType {
    var shouldSuccess: Bool = false
    var successMovies: [Movie] = []
    var fetchMoviesListCallCount = 0
    
    func fetchMoviesList() async -> Result<[SwiftCairoCommon.Movie], SwiftCairoCommon.NetworkError> {
        fetchMoviesListCallCount += 1
        if shouldSuccess {
            return .success(successMovies)
        } else {
            return .failure(.serverError)
        }
    }
}
