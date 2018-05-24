//
//  RealmManager.swift
//  MovieDatabase
//
//  Created by Anton Komin on 23.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate let _sharedInstance = RealmManager()

public class RealmManager {
    
    let realm = try! Realm()
    
    static var sharedInstance: RealmManager {
        return _sharedInstance
    }
    
    fileprivate init(){}
    
    func realmWrite(_ block: (Realm)->Void, completion: (Bool, Error?)->Void) {
        do {
            try realm.safeWrite {
                block(realm)
                completion(true, nil)
            }
        } catch let error {
            completion(false, error)
        }
    }
    
    func getNewMovies(searchText: String) -> [Movie] {
        let realmMovies = realm.objects(Movie.self)
        if searchText.isEmpty {
            return Array(realmMovies)
        } else {
            return realmMovies.filter({$0.title.lowercased().contains(searchText.lowercased())})
        }
    }
    
    func getMovieDetails(id: Int) -> MovieDetails? {
        return realm.objects(MovieDetails.self).filter({$0.id == id}).first
    }
}
