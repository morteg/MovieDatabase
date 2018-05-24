//
//  Movie.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic private var _releaseDate: String = ""
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var voteAvarage: Double = 0
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case overview
        case _releaseDate = "release_date"
        case voteCount = "vote_count"
        case voteAvarage = "vote_average"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Movie {
    var releaseDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: _releaseDate)
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {return nil}
        let fullPath = "https://image.tmdb.org/t/p/w500/" + posterPath
        return URL(string: fullPath)
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else {return nil}
        let fullPath = "https://image.tmdb.org/t/p/w500/" + backdropPath
        return URL(string: fullPath)
    }
}
