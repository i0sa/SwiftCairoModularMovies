//
//  MoviesDetailsConfigurator.swift
//  MovieDetailsFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import UIKit
import SwiftCairoCommon
import SwiftUI

public protocol MovieDetailsConfiguratorType: SwiftCairoFeature {
    func configure(dependencies: DependencyContainerType, navigator: Navigator) -> UIViewController
}

public class MovieDetailsConfigurator: MovieDetailsConfiguratorType {
    public init() { }
    public var featureId: String { return "MovieDetails" }
    
    public func configure(dependencies: DependencyContainerType, navigator: Navigator) -> UIViewController {
        let hostController = UIHostingController(rootView: MovieDetailsView())
        return hostController
    }
}
