//
//  MoviesAPIManager.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import ReactiveSwift


struct MoviesAPIManager {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let baseURL: URL? = URL(string: Movies.API.baseURLpath)
}

extension MoviesAPIManager: MoviesRequest {
    func fetchNowPlaying<T: Codable>(text: String = "", page: Int) -> SignalProducer<T, MoviesError> {
        guard let baseURL = baseURL else {
            return SignalProducer(error: .urlError)
        }
        let request = NowPlayingRequest(page: page).request(with: baseURL)
        let session = self.session
        return SignalProducer<T, MoviesError> { (observer, _) in
            session.dataTask(with: request) { (data, response, error) in
                do {
                    guard let data = data else {
                        observer.send(error: .dataCorrupted)
                        return
                    }
                    let model = try JSONDecoder().decode(T.self, from: data)
                    observer.send(value: model)
                } catch let error {
                    print(error)
                    observer.send(error: .decodingError)
                }
                observer.sendCompleted()
            }.resume()
        }
    }
}

extension MoviesAPIManager: MoviesSearchRequest {
    func search(text: String, page: Int) -> SignalProducer<Movies.SearchResults, MoviesError> {
        fetchNowPlaying(text: text, page: page)
    }
}
