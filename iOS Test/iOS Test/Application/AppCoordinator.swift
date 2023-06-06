//
//  AppCoordinator.swift
//  iOS Test
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import MoviesListFeature
import MovieDetailsFeature
import SwiftCairoCommon

class AppCoordinator {
    private let window: UIWindow
    private let dependencies: DependencyContainer
    private let navigator: Navigator
    private let navigationController: UINavigationController

    init(window: UIWindow,
         dependencies: DependencyContainer,
         navigationController: UINavigationController,
         navigator: Navigator) {
        self.window = window
        self.dependencies = dependencies
        self.navigationController = navigationController
        self.navigator = navigator
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        navigator.navigate(to: .moviesList, type: .root)
    }
}
