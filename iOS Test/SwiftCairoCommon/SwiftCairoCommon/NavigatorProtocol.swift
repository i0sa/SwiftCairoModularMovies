//
//  NavigatorProtocol.swift
//  MovieDetailsFeature
//
//  Created by Osama Gamal on 06/06/2023.
//

import Foundation

public enum Destination {
    case moviesList
    case movieDetails(movie: Movie)
}

public enum NavigationType {
    case push, root
}

public protocol Navigator {
    func navigate(to destination: Destination, type: NavigationType)
}
