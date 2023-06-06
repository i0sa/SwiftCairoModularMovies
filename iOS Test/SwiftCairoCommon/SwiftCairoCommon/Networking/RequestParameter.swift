//
//  RequestParameter.swift
//  ConsumerNetworking
//
//  Created by Osama Gamal on 23/03/2023.
//

import Foundation
public struct RequestParameter {
    public let name: String
    public let value: Parameter

    public init(name: String, value: Parameter) {
        self.name = name
        self.value = value
    }
}
