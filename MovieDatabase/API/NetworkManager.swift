//
//  MoviesDataManager.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {
    
    static let movieDBProvider = MoyaProvider<MovieDBService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static func getNewMovies(page: Int, completion: @escaping (Error?, [Movie], Int) ->()) {
        movieDBProvider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let moviesResponse = try JSONDecoder().decode(MoviesRequestResponse.self, from: response.data)
                    RealmManager.sharedInstance.realmWrite({ realm in
                        realm.add(moviesResponse.movies, update: true)
                    }) { success, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    completion(nil, moviesResponse.movies, moviesResponse.totalPages)
                } catch let error {
                    print(error.localizedDescription)
                    completion(error, [], 0)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                completion(error, [], 0)
            }
        }
    }
    
    static func getMovieDetails(id: Int, completion: @escaping (Error?, MovieDetails?) ->()) {
        movieDBProvider.request(.movieDetails(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let moviesDetails = try JSONDecoder().decode(MovieDetails.self, from: response.data)
                    RealmManager.sharedInstance.realmWrite({ realm in
                        realm.add(moviesDetails, update: true)
                    }) { success, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    completion(nil, moviesDetails)
                } catch let error {
                    print(error.localizedDescription)
                    completion(error, nil)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                completion(error, nil)
            }
        }
    }
    
    static func searchMovie(searchString: String, page: Int, completion: @escaping (Error?, [Movie], Int) ->()) {
        movieDBProvider.request(.searchMovies(searchString: searchString, page: page)) {
            result in
            switch result {
            case let .success(response):
                do {
                    let moviesResponse = try JSONDecoder().decode(MoviesRequestResponse.self, from: response.data)
                    RealmManager.sharedInstance.realmWrite({ realm in
                        realm.add(moviesResponse.movies, update: true)
                    }) { success, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    completion(nil, moviesResponse.movies, moviesResponse.totalPages)
                } catch let error {
                    print(error.localizedDescription)
                    completion(error, [], 0)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                completion(error, [], 0)
            }
        }
    }
}
