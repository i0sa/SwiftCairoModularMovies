//
//  SwiftCairoCacheService.swift
//  SwiftCairoCache
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import SwiftCairoCommon

public class SwiftCairoCacheService: SwiftCairoCache {
    private let serviceName: String
    private let userDefaults: UserDefaults?
    
    public init(serviceName: String) {
        self.serviceName = serviceName
        self.userDefaults = UserDefaults(suiteName: serviceName)
    }
    
    public func save<T: Codable>(_ object: T, forKey key: String) throws {
        guard let userDefaults = userDefaults else {
            throw SwiftCairoCacheError.userDefaultsInitializationError
        }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Error encoding object: \(error)")
            throw SwiftCairoCacheError.encodingError
        }
    }
    
    public func fetch<T: Codable>(forKey key: String) throws -> T {
        let decoder = JSONDecoder()
        if let data = userDefaults?.data(forKey: key) {
            do {
                let object = try decoder.decode(T.self, from: data)
                return object
            } catch {
                throw SwiftCairoCacheError.decodingError
            }
        }
        throw SwiftCairoCacheError.noData
    }
}
