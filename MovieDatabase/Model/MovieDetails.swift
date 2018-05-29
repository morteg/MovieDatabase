//
//  MovieDetails.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class  MovieDetails : Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var budget: Int = 0
    var genres = List<Genre>()
    var productionCountries = List<ProductionCountry>()
    @objc dynamic var revenue: Int = 0
    var videos = List<MovieVideo>()
    
    private enum CodingKeys: String, CodingKey {
        case id
        case budget
        case genres = "genres"
        case productionCountries = "production_countries"
        case revenue
        case videos = "videos"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
        
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    convenience init(id: Int, budget: Int, genres: List<Genre>, productionCountries: List<ProductionCountry>, revenue: Int, videos: List<MovieVideo>) {
        self.init()
        self.id = id
        self.budget = budget
        self.genres = genres
        self.productionCountries = productionCountries
        self.revenue = revenue
        self.videos = videos
    }
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(Int.self, forKey: .id)
        let budget = try values.decode(Int.self, forKey: .budget)
        let genresArray = try values.decode([Genre].self, forKey: .genres)
        let genres = List<Genre>()
        genres.append(objectsIn: genresArray)
        let productionCountriesArray = try values.decode([ProductionCountry].self, forKey: .productionCountries)
        let productionCountries = List<ProductionCountry>()
        productionCountries.append(objectsIn: productionCountriesArray)
        let revenue = try values.decode(Int.self, forKey: .revenue)
        let videosResults: [String: [MovieVideo]] = try values.decode([String: [MovieVideo]].self, forKey: .videos)
        let videosArray = videosResults["results"] ?? []
        let videos = List<MovieVideo>()
        videos.append(objectsIn: videosArray)
        
        self.init(id: id, budget: budget, genres: genres, productionCountries: productionCountries, revenue: revenue, videos: videos)
    }
    
}
