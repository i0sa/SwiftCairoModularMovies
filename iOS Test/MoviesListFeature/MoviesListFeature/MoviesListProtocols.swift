//
//  MoviesListConfigurator.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation
protocol MoviesListSceneDisplayLogic: AnyObject {
    func displayMovies(_ viewModel: MoviesListViewModel)
    func displayLoadingMoviesList()
    func displayFetchMoviesFailure()
}

protocol MoviesListSceneBusinessLogic {
    func fetchMoviesList()
    func selectMovieAtIndex(index: Int)
}

protocol MoviesListScenePresentationLogic {
    func presentWillFetchMovies()
    func presentMovies(_ response: MoviesPresentationResponse)
}
