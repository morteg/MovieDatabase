//
//  MoviesRequestResponse.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation

struct MoviesRequestResponse: Decodable, Equatable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
}
