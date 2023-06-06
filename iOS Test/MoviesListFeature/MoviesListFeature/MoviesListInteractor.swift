//
//  MoviesListInteractor.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation
import SwiftCairoCommon

final class MoviesListInteractor: MoviesListSceneBusinessLogic {
    //MARK: Stored Properties
    let presenter: MoviesListScenePresentationLogic
    let navigator: Navigator
    let worker: MoviesListWorkerType
    private let maxSelectableMovies: Int
    var selectedMovies: [Movie] = []
    var movies: [Movie]?
    
    init(presenter: MoviesListScenePresentationLogic,
         navigator: Navigator,
         worker: MoviesListWorkerType,
         maxSelectableMovies: Int = 5) {
        self.presenter = presenter
        self.navigator = navigator
        self.worker = worker
        self.maxSelectableMovies = maxSelectableMovies
    }
    
    func fetchMoviesList() {
        presenter.presentWillFetchMovies()
        Task { [weak self] in
            guard let self = self else { return }
            let moviesResult = await self.worker.fetchMoviesList()
            switch moviesResult {
            case .success(let movies):
                self.movies = movies
                let response = MoviesPresentationResponse.success(.init(movies: movies, selectedMovies: self.selectedMovies))
                presenter.presentMovies(response)
            case .failure(let error):
                presenter.presentMovies(.failure(error))
            }
        }
    }
    
    func selectMovieAtIndex(index: Int) {
        if let selectedMovie = self.movies?[index] {
            navigator.navigate(to: .movieDetails, type: .push)
        }
    }
}
