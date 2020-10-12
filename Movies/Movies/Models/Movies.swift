//
//  Movies.swift
//  Movies
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
enum Movies { }

extension Movies {
    struct SearchResults: Codable, Equatable {
        let dates: Dates?
        let movies: [Movie]?
        let page: Int?
        let totalPages: Int?
        let totalResults: Int?
    }
}
