import XCTest
@testable import MoviesListFeature

class MoviesListInteractorMock: MoviesListSceneBusinessLogic {
    var fetchMoviesListCallsCount = 0
    var selectMovieAtIndexCallsCount = 0
    var lastSelectedMovieIndex: Int?
    
    func fetchMoviesList() {
        fetchMoviesListCallsCount += 1
    }
    
    func selectMovieAtIndex(index: Int) {
        selectMovieAtIndexCallsCount += 1
        lastSelectedMovieIndex = index
    }
}
