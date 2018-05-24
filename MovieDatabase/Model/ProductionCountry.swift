//
//  ProductionCountry.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import RealmSwift

class ProductionCountry: Object, Decodable {
    @objc dynamic var iso_3166_1: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "iso_3166_1"
    }
    
}
