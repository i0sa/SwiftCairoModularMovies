import XCTest
@testable import MoviesListFeature

class MoviesListViewControllerTests: XCTestCase {
    var sut: MoviesListViewController!
    var interactorMock: MoviesListInteractorMock!
    var tableView: UITableView {
        return sut.tableView
    }

    override func setUpWithError() throws {
        interactorMock = MoviesListInteractorMock()
        let viewController = MoviesListViewController()
        viewController.interactor = interactorMock
        self.sut = viewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        interactorMock = nil
    }

    func test_fetchMoviesList_Called_Once_In_ViewDidLoad() throws {
        // When
        sut.loadViewIfNeeded()
        // Then
        XCTAssertEqual(interactorMock.fetchMoviesListCallsCount, 1)
    }
    
    func test_numberOfRows_Returns_CorrectCount() {
        let viewModel = MoviesListViewModel(movies: [
            MovieViewModel.stub(),
            MovieViewModel.stub()
        ])
        sut.displayMovies(viewModel)

        let numberOfRows = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2)
    }

    func test_didSelectRow_Calls_Interactor_SelectMovieAtIndex() {
        let viewModel = MoviesListViewModel(movies: [
            MovieViewModel.stub()
        ])
        sut.displayMovies(viewModel)

        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(interactorMock.selectMovieAtIndexCallsCount, 1)
    }
}
