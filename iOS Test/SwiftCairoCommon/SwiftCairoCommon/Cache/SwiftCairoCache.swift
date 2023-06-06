//
//  SwiftCairoCache.swift
//  SwiftCairoCommon
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import UIKit

public protocol SwiftCairoCache {
    func save<T: Codable>(_ object: T, forKey key: String) throws
    func fetch<T: Codable>(forKey key: String) throws -> T
}
