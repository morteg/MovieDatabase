//
//  MovieVideo.swift
//  MovieDatabase
//
//  Created by Anton Komin on 20.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import RealmSwift

class MovieVideo : Object, Decodable {
    @objc dynamic var id: String = ""
    @objc dynamic var iso_639_1: String = ""
    @objc dynamic var iso_3166_1: String = ""
    @objc dynamic var key: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var site: String = ""
    @objc dynamic var size: Int = 0
    @objc dynamic private var _type: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case iso_639_1
        case iso_3166_1
        case key
        case name
        case site
        case size
        case _type = "type"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension MovieVideo {
    var videoType: MovieVideoType {
        return MovieVideoType(rawValue: _type) ?? .none
    }
}

enum MovieVideoType: String {
    case none = ""
    case trailer = "Trailer"
    case teaser = "Teaser"
    case clip = "Clip"
    case featurette = "Featurette"
}
