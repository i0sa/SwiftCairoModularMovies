//
//  NetworkingService.swift
//  ConsumerNetworking
//
//  Created by Osama Gamal on 23/03/2023.
//

import Foundation
import SwiftCairoCommon

public class NetworkingService: NetworkingType {
    private let requestBuilder: RequestBuilderType
    private let urlSession: URLSessionType

    public init(requestBuilder: RequestBuilderType = RequestBuilder(),
                urlSession: URLSessionType = URLSession.shared) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
    }

    public func request<R>(_ resource: R) async -> Result<R.Response, NetworkError> where R: ResourceType {
        // Create request
        let request: URLRequest
        
        do {
            request = try requestBuilder.createURLRequest(for: resource)
        } catch {
            return .failure(.invalidRequest)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return .failure(.serverError)
            }
            
            let parsedResponse = try resource.parse(data: data, response: httpResponse)
            
            return .success(parsedResponse)
        } catch {
            return .failure(.networkError)
        }
    }
}
