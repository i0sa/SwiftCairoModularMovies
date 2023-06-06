//
//  AppCoordinator.swift
//  iOS Test
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import MoviesListFeature

class AppCoordinator {
    private let window: UIWindow
    private let dependencies: DependencyContainer
    private let moviesListFeature: MoviesListConfiguratorType

    init(window: UIWindow, dependencies: DependencyContainer) {
        self.window = window
        self.dependencies = dependencies
        self.moviesListFeature = MoviesListConfigurator()
    }

    func start() {
        let cacheDependency = CacheProxy(feature: moviesListFeature)
        let dependencies = DependencyContainer(cache: cacheDependency)
        let moviesListViewController = moviesListFeature.configure(dependencies: dependencies)
        let navigationController = UINavigationController(rootViewController: moviesListViewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
