//
//  MoviesListConfigurator.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import SwiftCairoCommon

struct MoviesListViewModel {
    let movies: [MovieViewModel]
}

struct MovieViewModel {
    let title: String
    let subtitle: String
    let image: Image
    
    enum Image {
        case none
        case url(url: URL)
    }
}

typealias MoviesPresentationResponse = Result<MoviesPresentationData, NetworkError>
struct MoviesPresentationData {
    let movies: [Movie]
    let selectedMovies: [Movie]
}
