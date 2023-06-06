//
//  AppFlowCoordinator.swift
//  iOS Test
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation
import SwiftCairoCommon
import ConsumerNetworking

final class DependencyContainer: DependencyContainerType {
    let networking: NetworkingType
    let cache: SwiftCairoCache
    
    init(
        networking: NetworkingType = NetworkingService(),
        cache: SwiftCairoCache
    ) {
        self.networking = networking
        self.cache = cache
    }
}
