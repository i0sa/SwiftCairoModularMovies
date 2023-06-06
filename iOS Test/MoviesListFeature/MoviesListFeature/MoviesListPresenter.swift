//
//  MoviesListPresenter.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import SwiftCairoCommon

final class MoviesListPresenter {
    weak var viewController: MoviesListSceneDisplayLogic?
    
    init() {
    }
}

extension MoviesListPresenter: MoviesListScenePresentationLogic {
    func presentWillFetchMovies() {
        viewController?.displayLoadingMoviesList()
    }
    
    func presentMovies(_ response: MoviesPresentationResponse) {
        switch response {
        case .success(let moviesResponse):
            let moviesViewModels: [MovieViewModel] = moviesResponse.movies.map { movie in
                let isSelected = moviesResponse.selectedMovies.contains(movie)
                let viewModel = makeMovieViewModelForMovie(movie, isSelected: isSelected)
                return viewModel
            }
            viewController?.displayMovies(.init(movies: moviesViewModels))
        case .failure(let error):
            viewController?.displayFetchMoviesFailure()
        }
    }
}

private extension MoviesListPresenter {
    func makeMovieViewModelForMovie(_ movie: Movie, isSelected: Bool) -> MovieViewModel {
        
        let image: MovieViewModel.Image
        if let imageURL = URL(string: movie.poster) {
            image = .url(url: imageURL)
        } else {
            image = .none
        }
        return MovieViewModel(title: movie.title,
                              subtitle: "\(movie.year)",
                               image: image)
    }
}

