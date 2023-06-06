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
        case .movieDetails:
            navigateToMovieDetails(navigationType: type)
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
        
        switch navigationType {
        case .push:
            navigationController.pushViewController(moviesListViewController, animated: true)
        case .root:
            navigationController.setViewControllers([moviesListViewController], animated: false)
        }
    }
    
    func navigateToMovieDetails(navigationType: NavigationType) {
        let view = movieDetailsFeature.configure(dependencies: dependencies, navigator: self)
        
        switch navigationType {
        case .push:
            navigationController.pushViewController(view, animated: true)
        case .root:
            navigationController.setViewControllers([view], animated: false)
        }
    }
}
