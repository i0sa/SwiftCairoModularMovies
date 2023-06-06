//
//  Movie.swift
//  SwiftCairoCommon
//
//  Created by Osama Gamal on 24/03/2023.
//

import Foundation

public struct Movie: Codable, Equatable {
    public init(title: String, year: Int, poster: String) {
        self.title = title
        self.year = year
        self.poster = poster
    }
    
    public let title: String
    public let year: Int
    public let poster: String
}
