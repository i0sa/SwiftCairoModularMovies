import XCTest
@testable import MoviesListFeature

class MoviesListViewControllerMock: MoviesListSceneDisplayLogic {
    var displayLoadingMoviesListCallCount = 0
    var displayFetchMoviesFailureCallCount = 0
    var displayMoviesViewModel: MoviesListViewModel?
    var displayMoviesCallCount = 0
    
    func displayMovies(_ viewModel: MoviesListViewModel) {
        displayMoviesCallCount += 1
        self.displayMoviesViewModel = viewModel
    }
    
    func displayLoadingMoviesList() {
        displayLoadingMoviesListCallCount += 1
    }
    
    func displayFetchMoviesFailure() {
        displayFetchMoviesFailureCallCount += 1
    }
}
