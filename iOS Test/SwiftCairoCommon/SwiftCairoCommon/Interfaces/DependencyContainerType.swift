//
//  DependencyContainerType.swift
//  SwiftCairoCommon
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation

public protocol DependencyContainerType {
    var networking: NetworkingType { get }
    var cache: SwiftCairoCache { get }
}
