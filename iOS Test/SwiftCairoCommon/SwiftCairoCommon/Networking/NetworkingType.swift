//
//  NetworkingType.swift
//  Pods-iOS Test
//
//  Created by Osama Gamal on 23/03/2023.
//

import Foundation

public protocol NetworkingType {
    func request<R: ResourceType>(_ resource: R) async -> Result<R.Response, NetworkError>
}

