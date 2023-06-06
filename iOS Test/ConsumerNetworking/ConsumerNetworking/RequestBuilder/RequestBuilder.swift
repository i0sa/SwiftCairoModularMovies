//
//  RequestBuilder.swift
//  ConsumerNetworking
//
//  Created by Osama Gamal on 23/03/2023.
//

import Foundation
import SwiftCairoCommon

public protocol RequestBuilderType {
    func createURLRequest<R: ResourceType>(for resource: R) throws -> URLRequest
}

public class RequestBuilder: RequestBuilderType {
    public init() { }
    public func createURLRequest<R>(for resource: R) throws -> URLRequest where R: ResourceType {
        guard var urlComponents = URLComponents(string: resource.baseURL()) else {
            throw RequestBuildingError.invalidBaseURL
        }
        
        urlComponents.path = "/" + resource.path

        // Query
        let queryItems = resource.parameters.reduce(into: [(String, String)]()) { result, p in
            switch p.value {
            case .query(let v):
                result.append((p.name, v))
            default:
                break
            }
        }

        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = urlComponents.url else {
            throw RequestBuildingError.cannotBuildURL
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = resource.method.rawValue.uppercased()

        return urlRequest
    }
}

enum RequestBuildingError: Error {
    case invalidBaseURL
    case cannotBuildURL
}
