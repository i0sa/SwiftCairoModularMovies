//
//  MoviesListWorker.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation
import SwiftCairoCommon

protocol MoviesListWorkerType: FetchMoviesListUseCase { }

class MoviesListWorker: MoviesListWorkerType {
    let networkService: NetworkingType
    let cachingService: SwiftCairoCache
    let cachingEnabled: Bool
    
    init(networkService: NetworkingType,
         cachingService: SwiftCairoCache,
         cachingEnabled: Bool = true) {
        self.networkService = networkService
        self.cachingService = cachingService
        self.cachingEnabled = cachingEnabled
    }
    
    func fetchMoviesList() async -> Result<[Movie], NetworkError> {
        let resource = MoviesListResource()
        
        if cachingEnabled {
            do {
                let cachedMovies = try fetchCachedMovies()
                return .success(cachedMovies)
            } catch {
                let result = await networkService.request(resource)
                if case .success(let movies) = result {
                    try? cacheMovies(movies)
                }
                return result
            }
        } else {
            return await networkService.request(resource)
        }
        
    }
    
    private func cacheMovies(_ movies: [Movie]) throws {
        try cachingService.save(movies, forKey: "movies")
    }
    
    private func fetchCachedMovies() throws -> [Movie] {
        try cachingService.fetch(forKey: "movies")
    }
}
