//
//  MoviesListConfigurator.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import SwiftCairoCommon

public protocol MoviesListConfiguratorType: SwiftCairoFeature {
    func configure(dependencies: DependencyContainerType) -> MoviesListViewController
}

public class MoviesListConfigurator: MoviesListConfiguratorType {
    public init() { }
    public var featureId: String { return "MoviesList" }
    
    public func configure(dependencies: DependencyContainerType) -> MoviesListViewController {
        let presenter = MoviesListPresenter()
        let worker = MoviesListWorker(networkService: dependencies.networking,
                                       cachingService: dependencies.cache)
        let interactor = MoviesListInteractor(presenter: presenter,
                                               worker: worker)
        let viewController = MoviesListViewController()
        
        viewController.interactor = interactor
        presenter.viewController = viewController
        
        return viewController
    }
}
