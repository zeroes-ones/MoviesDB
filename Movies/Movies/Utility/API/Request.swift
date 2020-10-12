//
//  SearchRequest.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol MoviesRequest {
    func fetchNowPlaying(text: String, page: Int) -> SignalProducer<Movies.SearchResults, MoviesError>
}

protocol MoviesSearchRequest {
    func search(text: String, page: Int) -> SignalProducer<Movies.SearchResults, MoviesError>
}

struct NowPlayingRequest: APIRequest {
    var method: HttpMethod = .get
    var path: String = Movies.API.nowPlaying
    var parameters: [String : String] = [String: String]()
    init(page: Int) {
        parameters["api_key"] = Movies.API.key
        parameters["format"] = "json"
        parameters["language"] = String(describing: Movies.Language.en_us)
        parameters["page"] = "\(page)"
    }
}

struct SearchMoviesRequest: APIRequest {
    var method: HttpMethod = .get
    var path: String = Movies.API.searchPath
    var parameters: [String : String] = [String: String]()
    init(
        text: String,
        page: Int
    ) {
        parameters["api_key"] = Movies.API.key
        parameters["format"] = "json"
        parameters["language"] = String(describing: Movies.Language.en_us)
        parameters["page"] = "\(page)"
        parameters["query"] = text
    }
}
