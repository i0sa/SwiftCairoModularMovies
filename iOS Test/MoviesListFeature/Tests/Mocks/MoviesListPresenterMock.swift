import XCTest
@testable import MoviesListFeature

class MoviesListPresenterMock: MoviesListScenePresentationLogic {
    var presentWillFetchMoviesCallsCount = 0
    var presentMoviesResponse: MoviesListFeature.MoviesPresentationResponse?
    var presentMoviesCallsCount = 0
    
    func presentWillFetchMovies() {
        presentWillFetchMoviesCallsCount += 1
    }
    
    func presentMovies(_ response: MoviesListFeature.MoviesPresentationResponse) {
        presentMoviesCallsCount += 1
        self.presentMoviesResponse = response
    }
}
