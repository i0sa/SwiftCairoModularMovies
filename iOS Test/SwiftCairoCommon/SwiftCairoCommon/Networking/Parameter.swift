//
//  Parameter.swift
//  ConsumerNetworking
//
//  Created by Osama Gamal on 23/03/2023.
//

import Foundation
/// Request parameters data
public enum Parameter {
    /**
        URL-encoded query parameter
    ```
        // Definition Example
        var parameters: [RequestParameter] {
            return [
                .init(name: "pageId", value: .query("2")),
            ]
        }
    ```
    */
    case query(String)
    
    /// Potentially, we can introduce other parameter types, like .header
    /// and builder will be responsible for mapping it
}
