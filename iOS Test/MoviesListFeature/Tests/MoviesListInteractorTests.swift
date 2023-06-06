import XCTest
@testable import MoviesListFeature
import SwiftCairoCommon

class MoviesListInteractorTests: XCTestCase {
    var sut: MoviesListInteractor!
    var presenterMock: MoviesListPresenterMock!
    var workerMock: MoviesListWorkerMock!

    override func setUpWithError() throws {
        presenterMock = MoviesListPresenterMock()
        workerMock = MoviesListWorkerMock()
        self.sut = MoviesListInteractor(presenter: presenterMock,
                                               worker: workerMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
        workerMock = nil
    }

    func test_fetchMoviesList_Calls_WillFetchMoviesList() async {
        // When
        let task = Task {
            sut.fetchMoviesList()
        }
        await task.value

        // Then
        // Validate call count is only one
        XCTAssertEqual(presenterMock.presentWillFetchMoviesCallsCount, 1)
    }
    
    func test_fetchMoviesList_Calls_Worker_And_Success() async {
        // Given
        let mockMovies: [Movie] = [.stub(name: "Test 1"),
                                     .stub(name: "Test 2")]
        workerMock.shouldSuccess = true
        workerMock.successMovies = mockMovies
        // When
        let task = Task {
            sut.fetchMoviesList()
        }
        await task.value

        // Then
        // Validate call count for present is only one
        XCTAssertEqual(presenterMock.presentMoviesCallsCount, 1)
        // Validate call count for worker is only one
        XCTAssertEqual(workerMock.fetchMoviesListCallCount, 1)
        
        // Validate present response
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            XCTAssertEqual(moviesResponse.movies, workerMock.successMovies)
            XCTAssertEqual(moviesResponse.movies.count, 2)
        }
    }
    
    func test_selectMovieAtIndex_Single_Movie_Is_Added_To_SelectedMovies() async {
        // Given
        let maxSelectableMovies = 1
        self.sut = MoviesListInteractor(presenter: presenterMock,
                                               worker: workerMock,
                                         maxSelectableMovies: maxSelectableMovies)

        let mockMovies: [Movie] = [.stub(name: "Test 1"),
                                     .stub(name: "Test 2")]
        workerMock.shouldSuccess = true
        workerMock.successMovies = mockMovies
        let task = Task {
            sut.fetchMoviesList()
        }
        await task.value

        // Validate Before Selection, that there is no pre-selected movies
        XCTAssertTrue(sut.selectedMovies.isEmpty)

        // When
        sut.selectMovieAtIndex(index: 0)
        
        // Then
        // Validate call count for present is only one
        XCTAssertEqual(presenterMock.presentMoviesCallsCount, 2)
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            if moviesResponse.selectedMovies.indices.contains(0) {
                XCTAssertEqual(moviesResponse.selectedMovies[0], mockMovies[0])
            } else {
                XCTFail("Movie not found in selectedMovies")
            }
            
            XCTAssertEqual(moviesResponse.selectedMovies.count, 1)
            XCTAssertEqual(moviesResponse.movies.count, 2)
        }
    }
    
    func test_selectMovieAtIndex_Multiple_Movies_Are_Added_To_SelectedMovies() async throws {
        // Given
        let maxSelectableMovies = 5
        self.sut = MoviesListInteractor(presenter: presenterMock,
                                               worker: workerMock,
                                         maxSelectableMovies: maxSelectableMovies)

        let mockMovies: [Movie] = [.stub(id: "1"),
                                     .stub(id: "2"),
                                     .stub(id: "3")]
        workerMock.shouldSuccess = true
        workerMock.successMovies = mockMovies
        let task = Task {
            sut.fetchMoviesList()
        }
        await task.value

        // Validate Before Selection, that there is no pre-selected movies
        XCTAssertTrue(sut.selectedMovies.isEmpty)

        // When
        sut.selectMovieAtIndex(index: 0)
        sut.selectMovieAtIndex(index: 2)

        // Then
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            // Validates 1st item is selected
            if moviesResponse.selectedMovies.indices.contains(0) {
                XCTAssertEqual(moviesResponse.selectedMovies[0], mockMovies[0])
            } else {
                XCTFail("First Movie not found in selectedMovies")
            }

            // Validates 3rd mock item is selected
            if moviesResponse.selectedMovies.indices.contains(1) {
                XCTAssertEqual(moviesResponse.selectedMovies[1], mockMovies[2])
            } else {
                XCTFail("Third Movie not found in selectedMovies")
            }
            
            XCTAssertEqual(moviesResponse.selectedMovies.count, 2)
            // Assert sut local variable
            XCTAssertEqual(sut.selectedMovies.count, 2)

            XCTAssertEqual(moviesResponse.movies.count, 3)
        }
    }
    
    func test_selectMovieAtIndex_Respects_MaxSelectableMovies() async {
        // Given
        let maxSelectableMovies = 1
        self.sut = MoviesListInteractor(presenter: presenterMock,
                                               worker: workerMock,
                                         maxSelectableMovies: maxSelectableMovies)

        let mockMovies: [Movie] = [.stub(name: "Test 1"),
                                     .stub(name: "Test 2")]
        workerMock.shouldSuccess = true
        workerMock.successMovies = mockMovies
        let task = Task {
            sut.fetchMoviesList()
        }
        await task.value

        // Validate Before Selection, that there is no pre-selected movies
        XCTAssertTrue(sut.selectedMovies.isEmpty)

        // When
        sut.selectMovieAtIndex(index: 0)

        // Then
        // Validate call count for present is only one
        XCTAssertEqual(presenterMock.presentMoviesCallsCount, 2)
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            if moviesResponse.selectedMovies.indices.contains(0) {
                XCTAssertEqual(moviesResponse.selectedMovies[0], mockMovies[0])
            } else {
                XCTFail("Movie not found in selectedMovies")
            }
            
            XCTAssertEqual(moviesResponse.selectedMovies.count, 1)
            // Assert sut local variable
            XCTAssertEqual(sut.selectedMovies.count, 1)

            XCTAssertEqual(moviesResponse.movies.count, 2)
        }
        
        // When
        // -- Attempt to select another movie, while we previously selected one
        sut.selectMovieAtIndex(index: 1)

        // Then
        // Validate call count for present movies is second
        XCTAssertEqual(presenterMock.presentMoviesCallsCount, 2)
        // Validate that selected movies did not increase
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            if moviesResponse.selectedMovies.indices.contains(0) {
                XCTAssertEqual(moviesResponse.selectedMovies[0], mockMovies[0])
            } else {
                XCTFail("Movie not found in selectedMovies")
            }
            
            XCTAssertEqual(moviesResponse.selectedMovies.count, 1)
            // Assert sut local variable
            XCTAssertEqual(sut.selectedMovies.count, 1)

            XCTAssertEqual(moviesResponse.movies.count, 2)
        }
    }
    
    func test_selectMovieAtIndex_When_Selecting_Selected_Movie_It_Deselects_It() async {
        // Given
        let maxSelectableMovies = 1
        self.sut = MoviesListInteractor(presenter: presenterMock,
                                               worker: workerMock,
                                         maxSelectableMovies: maxSelectableMovies)

        let mockMovies: [Movie] = [.stub(name: "Test 1"),
                                     .stub(name: "Test 2")]
        workerMock.shouldSuccess = true
        workerMock.successMovies = mockMovies
        let task = Task {
            sut.fetchMoviesList()
        }
        await task.value

        // Validate Before Selection, that there is no pre-selected movies
        XCTAssertTrue(sut.selectedMovies.isEmpty)

        // When
        sut.selectMovieAtIndex(index: 0)
        
        // Then
        // Validate call count for present is only one
        XCTAssertEqual(presenterMock.presentMoviesCallsCount, 2)
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            if moviesResponse.selectedMovies.indices.contains(0) {
                XCTAssertEqual(moviesResponse.selectedMovies[0], mockMovies[0])
            } else {
                XCTFail("Movie not found in selectedMovies")
            }
            
            XCTAssertEqual(moviesResponse.selectedMovies.count, 1)
            // Assert sut local variable
            XCTAssertEqual(sut.selectedMovies.count, 1)

            XCTAssertEqual(moviesResponse.movies.count, 2)
        }
        
        // When
        sut.selectMovieAtIndex(index: 0)
        
        // Then
        // Validate call count for present movies is second
        XCTAssertEqual(presenterMock.presentMoviesCallsCount, 3)
        XCTAssertResultSuccess(presenterMock.presentMoviesResponse) { moviesResponse in
            XCTAssertEqual(moviesResponse.selectedMovies.count, 0)
            XCTAssertEqual(moviesResponse.movies.count, 2)

            // Assert sut local variable
            XCTAssertEqual(sut.selectedMovies.count, 0)
        }

    }


}
