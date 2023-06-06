//
//  CacheProxy.swift
//  iOS Test
//
//  Created by Osama Gamal on 25/03/2023.
//

import SwiftCairoCommon
import SwiftCairoCache

final class CacheProxy: SwiftCairoCache {
    let serviceName: String
    private let service: SwiftCairoCacheService
    
    init(serviceName: String) {
        self.serviceName = serviceName
        self.service = SwiftCairoCacheService(serviceName: serviceName)
    }
    
    convenience init(feature: SwiftCairoFeature) {
        self.init(serviceName: feature.featureId)
    }
    
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        try service.save(object, forKey: key)
    }
    
    func fetch<T: Codable>(forKey key: String) throws -> T {
        try service.fetch(forKey: key)
    }
}
