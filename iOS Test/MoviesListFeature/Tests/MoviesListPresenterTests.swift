import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

class MoviesListPresenterTests: XCTestCase {
    var sut: MoviesListScenePresentationLogic!
    var viewControllerMock: MoviesListViewControllerMock!

    override func setUpWithError() throws {
        viewControllerMock = MoviesListViewControllerMock()
        let moviePrepartionTimePresentationWorker = MoviePrepartionTimePresentationWorker()
        let presenter = MoviesListPresenter(moviePrepartionTimePresentationWorker: moviePrepartionTimePresentationWorker)
        presenter.viewController = viewControllerMock
        self.sut = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        viewControllerMock = nil
    }

    func test_presentWillFetchMovies_Calls_displayLoadingMoviesList() throws {
        sut.presentWillFetchMovies()
        XCTAssertEqual(viewControllerMock.displayLoadingMoviesListCallCount, 1)
    }
    
    func test_presentMovies_Success() throws {
        let stubMovie_1: Movie = .stub(
            name: "Test 1",
            headline: "Headline 1",
            image: "https://swiftcairo.com/1.jpg",
            preparationMinutes: 10)
        let stubMovie_2: Movie = .stub(
            name: "Test 2",
            headline: "Headline 2",
            image: "https://swiftcairo.com/2.jpg",
            preparationMinutes: 95)

        let response: MoviesPresentationData = .init(
            movies: [stubMovie_1, stubMovie_2],
            selectedMovies: []
        )
        sut.presentMovies(.success(response))

        let unwrappedMoviesViewModel = try XCTUnwrap(viewControllerMock.displayMoviesViewModel)
        
        let expectedMoviesViewModels: [MovieViewModel] = [
            .stub(title: "Test 1",
                  subtitle: "Headline 1",
                  preparationTimeText: "10 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/1.jpg")!),
                  isSelected: false),
            .stub(title: "Test 2",
                  subtitle: "Headline 2",
                  preparationTimeText: "1 Hr, 35 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/2.jpg")!),
                  isSelected: false),
        ]
        
        XCTAssertEqual(unwrappedMoviesViewModel.movies, expectedMoviesViewModels)
        
        // Validate there are only two movies as provided on success state
        XCTAssertEqual(unwrappedMoviesViewModel.movies.count, 2)

        // Validate number of calls is one
        XCTAssertEqual(viewControllerMock.displayMoviesCallCount, 1)
    }
    
    func test_presentMovies_Success_With_Invalid_Image_URL() throws {
        let stubMovie_1: Movie = .stub(
            name: "Test 1",
            headline: "Headline 1",
            image: "https://swiftcairo.com/1.jpg",
            preparationMinutes: 10)
        let stubMovie_2: Movie = .stub(
            name: "Test 2",
            headline: "Headline 2",
            image: "https://swiftcairo.com/1invalid url",
            preparationMinutes: 95)

        let response: MoviesPresentationData = .init(
            movies: [stubMovie_1, stubMovie_2],
            selectedMovies: []
        )
        sut.presentMovies(.success(response))

        let unwrappedMoviesViewModel = try XCTUnwrap(viewControllerMock.displayMoviesViewModel)
        
        let expectedMoviesViewModels: [MovieViewModel] = [
            .stub(title: "Test 1",
                  subtitle: "Headline 1",
                  preparationTimeText: "10 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/1.jpg")!),
                  isSelected: false),
            .stub(title: "Test 2",
                  subtitle: "Headline 2",
                  preparationTimeText: "1 Hr, 35 Min",
                  image: .none,
                  isSelected: false),
        ]
        
        XCTAssertEqual(unwrappedMoviesViewModel.movies, expectedMoviesViewModels)
        
        // Validate there are only two movies as provided on success state
        XCTAssertEqual(unwrappedMoviesViewModel.movies.count, 2)

        // Validate number of calls is one
        XCTAssertEqual(viewControllerMock.displayMoviesCallCount, 1)
    }

    func test_presentMovies_Preparation_Time() throws {
        let stubMovie_1: Movie = .stub(
            name: "Test 1",
            headline: "Headline 1",
            image: "https://swiftcairo.com/1.jpg",
            preparationMinutes: 10)
        let stubMovie_2: Movie = .stub(
            name: "Test 2",
            headline: "Headline 2",
            image: "https://swiftcairo.com/2.jpg",
            preparationMinutes: 95)

        let response: MoviesPresentationData = .init(
            movies: [stubMovie_1, stubMovie_2],
            selectedMovies: []
        )
        sut.presentMovies(.success(response))

        let unwrappedMoviesViewModel = try XCTUnwrap(viewControllerMock.displayMoviesViewModel)
        
        let expectedMoviesViewModels: [MovieViewModel] = [
            .stub(title: "Test 1",
                  subtitle: "Headline 1",
                  preparationTimeText: "10 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/1.jpg")!),
                  isSelected: false),
            .stub(title: "Test 2",
                  subtitle: "Headline 2",
                  preparationTimeText: "1 Hr, 35 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/2.jpg")!),
                  isSelected: false),
        ]
        
        XCTAssertEqual(unwrappedMoviesViewModel.movies, expectedMoviesViewModels)
        
        // Validate there are only two movies as provided on success state
        XCTAssertEqual(unwrappedMoviesViewModel.movies.count, 2)

        // Validate number of calls is one
        XCTAssertEqual(viewControllerMock.displayMoviesCallCount, 1)
    }

    
    func test_presentMovies_Failure() throws {
        sut.presentMovies(.failure(.networkError))

        // Validate number of calls is one for failure
        XCTAssertEqual(viewControllerMock.displayFetchMoviesFailureCallCount, 1)
    }
    
    func test_presentMovies_Marks_Movie_As_Selected_From_SelectedMovies() throws {
        let stubMovie_1: Movie = .stub(
            name: "Test 1",
            headline: "Headline 1",
            image: "https://swiftcairo.com/1.jpg",
            preparationMinutes: 10)
        let stubMovie_2: Movie = .stub(
            name: "Test 2",
            headline: "Headline 2",
            image: "https://swiftcairo.com/2.jpg",
            preparationMinutes: 10)

        let response: MoviesPresentationData = .init(
            movies: [stubMovie_1, stubMovie_2],
            selectedMovies: [stubMovie_2]
        )
        sut.presentMovies(.success(response))

        let unwrappedMoviesViewModel = try XCTUnwrap(viewControllerMock.displayMoviesViewModel)
        
        let expectedMoviesViewModels: [MovieViewModel] = [
            .stub(title: "Test 1",
                  subtitle: "Headline 1",
                  preparationTimeText: "10 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/1.jpg")!),
                  isSelected: false),
            .stub(title: "Test 2",
                  subtitle: "Headline 2",
                  preparationTimeText: "10 Min",
                  image: .url(url: URL(string: "https://swiftcairo.com/2.jpg")!),
                  isSelected: true),
        ]
        
        XCTAssertEqual(unwrappedMoviesViewModel.movies, expectedMoviesViewModels)
        
        // Validate there are only two movies as provided on success state
        XCTAssertEqual(unwrappedMoviesViewModel.movies.count, 2)

        // Validate number of calls is one
        XCTAssertEqual(viewControllerMock.displayMoviesCallCount, 1)
    }
}
