//
//  MovieDBApi.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import Moya

fileprivate let apiKey = "b744eb1b5be1cdbb7378e69ad3aef83d"

enum MovieDBService {
    case newMovies(page: Int)
    case movieDetails(id: Int)
    case searchMovies(searchString: String, page: Int)
}

extension MovieDBService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .newMovies:
            return "movie/now_playing"
        case .movieDetails(let id):
            return "movie/\(id)"
        case .searchMovies:
            return "search/movie"
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var method: Moya.Method {
        switch self {
        case .newMovies:
            return .get
        case .movieDetails:
            return .get
        case .searchMovies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .newMovies(let page):
            var params: [String: Any] = [:]
            params["api_key"] = apiKey
            params["page"] = page
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .movieDetails:
            var params: [String: Any] = [:]
            params["api_key"] = apiKey
            params["append_to_response"] = "videos"
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .searchMovies(let searchString, let page):
            var params: [String: Any] = [:]
            params["api_key"] = apiKey
            params["query"] = searchString
            params["page"] = page
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .newMovies:
            return """
            {
            "results": [
            {
            "vote_count": 3652,
            "id": 299536,
            "video": false,
            "vote_average": 8.5,
            "title": "Avengers: Infinity War",
            "popularity": 575.963952,
            "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
            "original_language": "en",
            "original_title": "Avengers: Infinity War",
            "genre_ids": [
            12,
            878,
            14,
            28
            ],
            "backdrop_path": "/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
            "adult": false,
            "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
            "release_date": "2018-04-25"
            },
            {
            "vote_count": 552,
            "id": 427641,
            "video": false,
            "vote_average": 5.9,
            "title": "Rampage",
            "popularity": 162.232542,
            "poster_path": "/30oXQKwibh0uANGMs0Sytw3uN22.jpg",
            "original_language": "en",
            "original_title": "Rampage",
            "genre_ids": [
            28,
            12,
            878
            ],
            "backdrop_path": "/wrqUiMXttHE4UBFMhLHlN601MZh.jpg",
            "adult": false,
            "overview": "Primatologist Davis Okoye shares an unshakable bond with George, the extraordinarily intelligent, silverback gorilla who has been in his care since birth.  But a rogue genetic experiment gone awry mutates this gentle ape into a raging creature of enormous size.  To make matters worse, it’s soon discovered there are other similarly altered animals.  As these newly created alpha predators tear across North America, destroying everything in their path, Okoye teams with a discredited genetic engineer to secure an antidote, fighting his way through an ever-changing battlefield, not only to halt a global catastrophe but to save the fearsome creature that was once his friend.",
            "release_date": "2018-04-12"
            },
            {
            "vote_count": 382,
            "id": 383498,
            "video": false,
            "vote_average": 8,
            "title": "Deadpool 2",
            "popularity": 155.303454,
            "poster_path": "/to0spRl1CMDvyUbOnbb4fTk3VAd.jpg",
            "original_language": "en",
            "original_title": "Deadpool 2",
            "genre_ids": [
            28,
            35,
            878
            ],
            "backdrop_path": "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg",
            "adult": false,
            "overview": "Wisecracking mercenary Deadpool battles the evil and powerful Cable and other bad guys to save a boy's life.",
            "release_date": "2018-05-15"
            },
            {
            "vote_count": 598,
            "id": 445571,
            "video": false,
            "vote_average": 7,
            "title": "Game Night",
            "popularity": 81.629902,
            "poster_path": "/85R8LMyn9f2Lev2YPBF8Nughrkv.jpg",
            "original_language": "en",
            "original_title": "Game Night",
            "genre_ids": [
            9648,
            35,
            80,
            53
            ],
            "backdrop_path": "/4hU1pC7MGQ7wU9ldkRJYNHK3vgb.jpg",
            "adult": false,
            "overview": "Max and Annie's weekly game night gets kicked up a notch when Max's brother Brooks arranges a murder mystery party -- complete with fake thugs and federal agents. So when Brooks gets kidnapped, it's all supposed to be part of the game. As the competitors set out to solve the case, they start to learn that neither the game nor Brooks are what they seem to be. The friends soon find themselves in over their heads as each twist leads to another unexpected turn over the course of one chaotic night.",
            "release_date": "2018-02-22"
            },
            {
            "vote_count": 1937,
            "id": 333339,
            "video": false,
            "vote_average": 7.8,
            "title": "Ready Player One",
            "popularity": 73.922215,
            "poster_path": "/pU1ULUq8D3iRxl1fdX2lZIzdHuI.jpg",
            "original_language": "en",
            "original_title": "Ready Player One",
            "genre_ids": [
            12,
            878,
            28
            ],
            "backdrop_path": "/q7fXcrDPJcf6t3rzutaNwTzuKP1.jpg",
            "adult": false,
            "overview": "When the creator of a popular video game system dies, a virtual contest is created to compete for his fortune.",
            "release_date": "2018-03-28"
            },
            {
            "vote_count": 660,
            "id": 268896,
            "video": false,
            "vote_average": 5.9,
            "title": "Pacific Rim: Uprising",
            "popularity": 61.872532,
            "poster_path": "/v5HlmJK9bdeHxN2QhaFP1ivjX3U.jpg",
            "original_language": "en",
            "original_title": "Pacific Rim: Uprising",
            "genre_ids": [
            28,
            14,
            878,
            12
            ],
            "backdrop_path": "/mo5EJsExrQCroqPDwUwp6jeq0xS.jpg",
            "adult": false,
            "overview": "It has been ten years since The Battle of the Breach and the oceans are still, but restless. Vindicated by the victory at the Breach, the Jaeger program has evolved into the most powerful global defense force in human history. The PPDC now calls upon the best and brightest to rise up and become the next generation of heroes when the Kaiju threat returns.",
            "release_date": "2018-03-21"
            },
            {
            "vote_count": 0,
            "id": 490214,
            "video": false,
            "vote_average": 0,
            "title": "Iceman 2",
            "popularity": 54.1057,
            "poster_path": "/enZENHd2gwVAw4sJKJxtJl1vJ09.jpg",
            "original_language": "cn",
            "original_title": "时空行者2",
            "genre_ids": [
            28,
            35,
            36
            ],
            "backdrop_path": null,
            "adult": false,
            "overview": "The imperial guard and his three traitorous childhood friends ordered to hunt him down get accidentally buried and kept frozen in time. 400 years later pass and they are defrosted continuing the battle they left behind",
            "release_date": "2018-05-18"
            },
            {
            "vote_count": 1819,
            "id": 300668,
            "video": false,
            "vote_average": 6.3,
            "title": "Annihilation",
            "popularity": 52.38733,
            "poster_path": "/d3qcpfNwbAMCNqWDHzPQsUYiUgS.jpg",
            "original_language": "en",
            "original_title": "Annihilation",
            "genre_ids": [
            9648,
            878,
            18,
            12,
            14,
            27,
            53
            ],
            "backdrop_path": "/6JD9ZfyumlxKPcxNJV9ZDW5iD8H.jpg",
            "adult": false,
            "overview": "A biologist signs up for a dangerous, secret expedition into a mysterious zone where the laws of nature don't apply.",
            "release_date": "2018-02-22"
            },
            {
            "vote_count": 12,
            "id": 348350,
            "video": false,
            "vote_average": 4.2,
            "title": "Solo: A Star Wars Story",
            "popularity": 44.923429,
            "poster_path": "/3IGbjc5ZC5yxim5W0sFING2kdcz.jpg",
            "original_language": "en",
            "original_title": "Solo: A Star Wars Story",
            "genre_ids": [
            28,
            12,
            878
            ],
            "backdrop_path": "/7LZ0K4FsALrt7OeNIGOVLNuKQRU.jpg",
            "adult": false,
            "overview": "Through a series of daring escapades deep within a dark and dangerous criminal underworld, Han Solo meets his mighty future copilot Chewbacca and encounters the notorious gambler Lando Calrissian.",
            "release_date": "2018-05-23"
            },
            {
            "vote_count": 132,
            "id": 460019,
            "video": false,
            "vote_average": 5.8,
            "title": "Truth or Dare",
            "popularity": 43.110395,
            "poster_path": "/zbvziwnZa91AJD78Si0hUb5JP5X.jpg",
            "original_language": "en",
            "original_title": "Truth or Dare",
            "genre_ids": [
            53,
            27
            ],
            "backdrop_path": "/eQ5xu2pQ5Kergubto5PbbUzey28.jpg",
            "adult": false,
            "overview": "A harmless game of “Truth or Dare” among friends turns deadly when someone—or something—begins to punish those who tell a lie—or refuse the dare.",
            "release_date": "2018-04-12"
            },
            {
            "vote_count": 113,
            "id": 437557,
            "video": false,
            "vote_average": 6.4,
            "title": "Blockers",
            "popularity": 42.295162,
            "poster_path": "/cx0LpfM6Drla8uzFfMT09uqKPRu.jpg",
            "original_language": "en",
            "original_title": "Blockers",
            "genre_ids": [
            35
            ],
            "backdrop_path": "/fqPIDVSTl6f1l02fb2rRVYPl5JE.jpg",
            "adult": false,
            "overview": "When three parents discover their daughters’ pact to lose their virginity at prom, they launch a covert one-night operation to stop the teens from sealing the deal.",
            "release_date": "2018-03-30"
            },
            {
            "vote_count": 85,
            "id": 387592,
            "video": false,
            "vote_average": 5.8,
            "title": "Early Man",
            "popularity": 41.680993,
            "poster_path": "/ugw07fJIZMVrrIGeN1MO7Xecj5h.jpg",
            "original_language": "en",
            "original_title": "Early Man",
            "genre_ids": [
            10751,
            35,
            16
            ],
            "backdrop_path": "/jyvWcB4PH1BSPo82t4h8sU4wr2a.jpg",
            "adult": false,
            "overview": "Set at the dawn of time when dinosaurs and woolly mammoths roamed the earth, Early Man tells the story of how one plucky caveman unites his tribe against a mighty enemy and saves the day.",
            "release_date": "2018-01-26"
            },
            {
            "vote_count": 1016,
            "id": 447332,
            "video": false,
            "vote_average": 7.3,
            "title": "A Quiet Place",
            "popularity": 39.491387,
            "poster_path": "/nAU74GmpUk7t5iklEp3bufwDq4n.jpg",
            "original_language": "en",
            "original_title": "A Quiet Place",
            "genre_ids": [
            18,
            27,
            53,
            878
            ],
            "backdrop_path": "/roYyPiQDQKmIKUEhO912693tSja.jpg",
            "adult": false,
            "overview": "A family is forced to live in silence while hiding from creatures that hunt by sound.",
            "release_date": "2018-04-05"
            },
            {
            "vote_count": 4126,
            "id": 353486,
            "video": false,
            "vote_average": 6.6,
            "title": "Jumanji: Welcome to the Jungle",
            "popularity": 36.057204,
            "poster_path": "/bXrZ5iHBEjH7WMidbUDQ0U2xbmr.jpg",
            "original_language": "en",
            "original_title": "Jumanji: Welcome to the Jungle",
            "genre_ids": [
            28,
            12,
            35,
            14
            ],
            "backdrop_path": "/rz3TAyd5kmiJmozp3GUbYeB5Kep.jpg",
            "adult": false,
            "overview": "The tables are turned as four teenagers are sucked into Jumanji's world - pitted against rhinos, black mambas and an endless variety of jungle traps and puzzles. To survive, they'll play as characters from the game.",
            "release_date": "2017-12-09"
            },
            {
            "vote_count": 18,
            "id": 385332,
            "video": false,
            "vote_average": 5.6,
            "title": "Terminal",
            "popularity": 33.605783,
            "poster_path": "/xi7pA3lL6Wb78p6Y6PgWoHDMjrM.jpg",
            "original_language": "en",
            "original_title": "Terminal",
            "genre_ids": [
            53,
            18,
            80
            ],
            "backdrop_path": "/bwvxvrHH3nTbcwpEcJhA72kkI94.jpg",
            "adult": false,
            "overview": "In the dark heart of a sprawling, anonymous city, two assassins carrying out a sinister mission, a teacher battles a fatal illness, and an enigmatic janitor and a curious waitress leading dangerous double lives. Murderous consequences unravel in the dead of night as their lives all intertwine at the hands of a mysterious criminal mastermind hell-bent on revenge.",
            "release_date": "2018-05-11"
            },
            {
            "vote_count": 482,
            "id": 449443,
            "video": false,
            "vote_average": 6.4,
            "title": "Den of Thieves",
            "popularity": 32.871166,
            "poster_path": "/AfybH6GbGFw1F9bcETe2yu25mIE.jpg",
            "original_language": "en",
            "original_title": "Den of Thieves",
            "genre_ids": [
            28,
            53,
            80
            ],
            "backdrop_path": "/s3FDBLH4qc1IcjexB05Qvbn3wxO.jpg",
            "adult": false,
            "overview": "A gritty crime saga which follows the lives of an elite unit of the LA County Sheriff's Dept. and the state's most successful bank robbery crew as the outlaws plan a seemingly impossible heist on the Federal Reserve Bank.",
            "release_date": "2018-01-18"
            },
            {
            "vote_count": 105,
            "id": 396806,
            "video": false,
            "vote_average": 5.9,
            "title": "Anon",
            "popularity": 29.801629,
            "poster_path": "/xhBTO9n3fxy3HJt7WlR9h9vvVmk.jpg",
            "original_language": "en",
            "original_title": "Anon",
            "genre_ids": [
            878,
            53
            ],
            "backdrop_path": "/arYvUXhpNRU2GQQut67P5cR0c5m.jpg",
            "adult": false,
            "overview": "Set in a near-future world where there is no privacy, ignorance or anonymity, our private memories are recorded and crime almost ceases to exist. In trying to solve a series of unsolved murders, Sal Frieland stumbles onto a young woman who appears to have subverted the system and disappeared. She has no identity, no history and no record. Sal realizes it may not be the end of crime but the beginning. Known only as 'The Girl', Sal must find her before he becomes the next victim.",
            "release_date": "2018-05-03"
            },
            {
            "vote_count": 2,
            "id": 502682,
            "video": false,
            "vote_average": 6.5,
            "title": "Book Club",
            "popularity": 29.724502,
            "poster_path": "/zHGf3PWSqwt3X1UEIO2ythLwvKO.jpg",
            "original_language": "en",
            "original_title": "Book Club",
            "genre_ids": [
            35,
            10749
            ],
            "backdrop_path": "/pozA8qiFEVY2A2ynM1mQwwhyQTW.jpg",
            "adult": false,
            "overview": "Four lifelong friends have their lives forever changed after reading Fifty Shades of Grey in their monthly book club.",
            "release_date": "2018-05-18"
            },
            {
            "vote_count": 274,
            "id": 453201,
            "video": false,
            "vote_average": 5.1,
            "title": "The 15:17 to Paris",
            "popularity": 29.611435,
            "poster_path": "/qxJQ0VBCuJkJhJmuWzxI408ngwd.jpg",
            "original_language": "en",
            "original_title": "The 15:17 to Paris",
            "genre_ids": [
            18,
            36,
            53
            ],
            "backdrop_path": "/wybwzeZ7mQDftmmrxOhcht35Qij.jpg",
            "adult": false,
            "overview": "In August 2015, an ISIS terrorist boarded train #9364 from Brussels to Paris. Armed with an AK-47 and enough ammo to kill more than 500 people, the terrorist might have succeeded except for three American friends who refused to give in to fear. One was a college student, one was a martial arts enthusiast and airman first class in the U.S. Air Force, and the other was a member of the Oregon National Guard, and all three pals proved fearless as they charged and ultimately overpowered the gunman after he emerged from a bathroom armed and ready to kill.",
            "release_date": "2018-02-02"
            },
            {
            "vote_count": 283,
            "id": 476926,
            "video": false,
            "vote_average": 5.4,
            "title": "The Titan",
            "popularity": 29.327103,
            "poster_path": "/qRmQazyIBZR4pQIk9VruiZul0Au.jpg",
            "original_language": "en",
            "original_title": "The Titan",
            "genre_ids": [
            878,
            53
            ],
            "backdrop_path": "/lvI088LImIcFNwLcniGyKMRbAK7.jpg",
            "adult": false,
            "overview": "On a bleak future Earth, a soldier endures a radical genetic transformation to save humanity. But his wife fears he's becoming more creature than man.",
            "release_date": "2018-03-30"
            }
            ],
            "page": 1,
            "total_results": 1009,
            "dates": {
                "maximum": "2018-05-24",
                "minimum": "2018-04-05"
            },
            "total_pages": 51
        }
        """.utf8Encoded
        case .movieDetails:
            return """
            {
            "adult": false,
            "backdrop_path": "/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg",
            "belongs_to_collection": null,
            "budget": 165000000,
            "genres": [
            {
            "id": 12,
            "name": "Adventure"
            },
            {
            "id": 18,
            "name": "Drama"
            },
            {
            "id": 878,
            "name": "Science Fiction"
            }
            ],
            "homepage": "http://www.interstellarmovie.net/",
            "id": 157336,
            "imdb_id": "tt0816692",
            "original_language": "en",
            "original_title": "Interstellar",
            "overview": "Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.",
            "popularity": 32.900739,
            "poster_path": "/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg",
            "production_companies": [
            {
            "id": 4,
            "logo_path": "/fycMZt242LVjagMByZOLUGbCvv3.png",
            "name": "Paramount",
            "origin_country": "US"
            },
            {
            "id": 923,
            "logo_path": "/5UQsZrfbfG2dYJbx8DxfoTr2Bvu.png",
            "name": "Legendary Entertainment",
            "origin_country": "US"
            },
            {
            "id": 9996,
            "logo_path": "/3tvBqYsBhxWeHlu62SIJ1el93O7.png",
            "name": "Syncopy",
            "origin_country": "GB"
            },
            {
            "id": 13769,
            "logo_path": null,
            "name": "Lynda Obst Productions",
            "origin_country": ""
            },
            {
            "id": 174,
            "logo_path": "/ky0xOc5OrhzkZ1N6KyUxacfQsCk.png",
            "name": "Warner Bros. Pictures",
            "origin_country": "US"
            }
            ],
            "production_countries": [
            {
            "iso_3166_1": "CA",
            "name": "Canada"
            },
            {
            "iso_3166_1": "US",
            "name": "United States of America"
            },
            {
            "iso_3166_1": "GB",
            "name": "United Kingdom"
            }
            ],
            "release_date": "2014-11-05",
            "revenue": 675120017,
            "runtime": 169,
            "spoken_languages": [
            {
            "iso_639_1": "en",
            "name": "English"
            }
            ],
            "status": "Released",
            "tagline": "Mankind was born on Earth. It was never meant to die here.",
            "title": "Interstellar",
            "video": false,
            "vote_average": 8.1,
            "vote_count": 14101,
            "videos": {
            "results": [
            {
            "id": "5794fffbc3a36829ab00056f",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "2LqzF5WauAw",
            "name": "Interstellar Movie - Official Trailer",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            },
            {
            "id": "57817a91c3a36873ea000adf",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "nyc6RJEEe0U",
            "name": "Interstellar Movie - Official Teaser",
            "site": "YouTube",
            "size": 1080,
            "type": "Teaser"
            },
            {
            "id": "57817aa69251417bfc000a58",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "zSWdZVtXT7E",
            "name": "Interstellar - Trailer - Official Warner Bros. UK",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            },
            {
            "id": "57817ab4c3a36813870024b7",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "KlyknsTJk0w",
            "name": "INTERSTELLAR - Own it TODAY on Blu-ray and DIGITAL HD!",
            "site": "YouTube",
            "size": 1080,
            "type": "Teaser"
            },
            {
            "id": "57817accc3a368592500392e",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "0vxOhd4qlnA",
            "name": "Interstellar Movie - Official Trailer 3",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            },
            {
            "id": "57817ada9251417c28000b02",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "827FNDpQWrQ",
            "name": "Interstellar - Teaser Trailer - Official Warner Bros. UK",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            },
            {
            "id": "57817b0fc3a368592500394d",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "LY19rHKAaAg",
            "name": "Interstellar – Trailer 4 – Official Warner Bros.",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            },
            {
            "id": "5795006f92514142390035ae",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "Rt2LHkSwdPQ",
            "name": "Interstellar Movie - Official Trailer 2",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            },
            {
            "id": "5add84850e0a2608d8009256",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "ePbKGoIGAXY",
            "name": "Interstellar – Trailer 3 – Official Warner Bros.",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
            }
            ]
            }
            }
            """.utf8Encoded
        case .searchMovies: //Search string = Deadpool 2
            return """
                {
                "page": 1,
                "total_results": 1,
                "total_pages": 1,
                "results": [
            {
              "vote_count": 811,
              "id": 383498,
              "video": false,
              "vote_average": 8,
              "title": "Deadpool 2",
              "popularity": 303.43477,
              "poster_path": "/to0spRl1CMDvyUbOnbb4fTk3VAd.jpg",
              "original_language": "en",
              "original_title": "Deadpool 2",
              "genre_ids": [
                28,
                35,
                878
              ],
              "backdrop_path": "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg",
              "adult": false,
              "overview": "Wisecracking mercenary Deadpool battles the evil and powerful Cable and other bad guys to save a boy's life.",
              "release_date": "2018-05-15"
            }
                ]
                }
    """.utf8Encoded
        }
    }
    
}
