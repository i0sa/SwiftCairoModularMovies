//
//  FetchMoviesListUseCase.swift
//  SwiftCairoCommon
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation
public protocol FetchMoviesListUseCase {
    func fetchMoviesList() async -> Result<[Movie], NetworkError>
}
