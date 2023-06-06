//
//  SwiftCairoCacheError.swift
//  SwiftCairoCache
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation

public enum SwiftCairoCacheError: Error {
    case userDefaultsInitializationError
    case encodingError
    case decodingError
    
    case noData
}
