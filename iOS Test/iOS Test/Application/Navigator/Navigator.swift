//
//  Navigator.swift
//  iOS Test
//
//  Created by Osama Gamal on 06/06/2023.
//

import Foundation
import UIKit
import MoviesListFeature
import MovieDetailsFeature
import SwiftCairoCommon

class NavigatorImpl: Navigator {
    private let dependencies: DependencyContainer
    private let moviesListFeature: MoviesListConfiguratorType
    private let movieDetailsFeature: MovieDetailsConfiguratorType
    private var navigationController: UINavigationController
    
    
    func navigate(to destination: SwiftCairoCommon.Destination, type: SwiftCairoCommon.NavigationType) {
        switch destination {
        case .moviesList:
            navigateToMoviesList(navigationType: type)
        case .movieDetails(let movie):
            navigateToMovieDetails(movie: movie, navigationType: type)
        }
    }
    
    init(dependencies: DependencyContainer,
         navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
        
        self.moviesListFeature = MoviesListConfigurator()
        self.movieDetailsFeature = MovieDetailsConfigurator()
    }

    func navigateToMoviesList(navigationType: NavigationType) {
        let cacheDependency = CacheProxy(feature: moviesListFeature)
        let dependencies = DependencyContainer(cache: cacheDependency)
        let moviesListViewController = moviesListFeature.configure(dependencies: dependencies, navigator: self)
        navigateToViewControllerWithType(viewController: moviesListViewController, type: navigationType)
    }
    
    func navigateToMovieDetails(movie: Movie, navigationType: NavigationType) {
        let view = movieDetailsFeature.configure(dependencies: dependencies, navigator: self, movie: movie)
        navigateToViewControllerWithType(viewController: view, type: navigationType)
    }
    
    private func navigateToViewControllerWithType(viewController: UIViewController, type: NavigationType) {
        switch type {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .root:
            navigationController.setViewControllers([viewController], animated: false)
        }
    }
}
