//
//  MoviesListResource.swift
//  MoviesListFeature
//
//  Created by Osama Gamal on 24/03/2023.
//

import SwiftCairoCommon

struct MoviesListResource: ResourceType {
    let method: HTTPMethod = .get
    let path = "b/B74P"
    let parameters: [RequestParameter] = []
    
    func baseURL() -> String {
        return "https://www.jsonkeeper.com"
    }
    
    func parse(data: Data, response: HTTPURLResponse) throws -> [Movie] {
        let decoder = JSONDecoder()
        let data = try decoder.decode([Movie].self, from: data)
        return data
    }
}


