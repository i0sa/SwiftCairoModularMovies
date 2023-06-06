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
    let worker: MoviesListWorkerType
    private let maxSelectableMovies: Int
    var selectedMovies: [Movie] = []
    var movies: [Movie]?
    
    init(presenter: MoviesListScenePresentationLogic,
         worker: MoviesListWorkerType,
         maxSelectableMovies: Int = 5) {
        self.presenter = presenter
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
            if let selectedMovieIndex = selectedMovies.firstIndex(where: { $0 == selectedMovie }) {
                selectedMovies.remove(at: selectedMovieIndex)
            } else {
                guard selectedMovies.count < maxSelectableMovies else { return }
                selectedMovies.append(selectedMovie)
            }
            
            guard let movies = self.movies else {
                // Technically at this point, it will not come here, because the block user is in here, is based on checking index existance of selected movie, so movies cannot be nil, unless it was manipulated to nill before this check, there are two possible things to do here:
                // - Do fatalError here to notify dev team of something is wrong
                // - Present error to user, and add analytics critical logging of something is wrong, to not to break user experience from fatal crash
                return
            }
            let response = MoviesPresentationResponse.success(.init(movies: movies, selectedMovies: self.selectedMovies))
            presenter.presentMovies(response)
        }
    }
}
