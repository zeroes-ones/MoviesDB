//
//  Constants.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
extension Movies {
    struct API {
        static let baseURLpath = "https://api.themoviedb.org/3"
        static let key = "7bfe007798875393b05c5aa1ba26323e"
        static let nowPlaying = "/movie/now_playing"
        static let searchPath = "/search/movie"
        static let posterURL = "https://image.tmdb.org/t/p/w500"
    }

    enum Language: CustomStringConvertible {
        case en_us

        var description: String {
             // Use Internationalization, as appropriate.
            switch self {
            case .en_us:
                return "en-US"
            }
        }
    }
}
