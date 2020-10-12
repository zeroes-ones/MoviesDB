//
//  MoviesViewModel.swift
//  Movies
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import ReactiveSwift

typealias MoviesAPIRequest = MoviesRequest & MoviesSearchRequest

struct MoviesViewModel {

    let searchRequest: MoviesAPIRequest
    var movies: MutableProperty<[Movies.SearchResults]> = MutableProperty([])
    private var currentPage: MutableProperty<Int> = MutableProperty(0)
    private var disposableBag = CompositeDisposable()
    private var search: MutableProperty<(page: Int, text: String)> = MutableProperty((page: 0, text: ""))
    init(_ searchRequest: MoviesAPIRequest) {
        self.searchRequest = searchRequest
    }
}

// MARK:- Internal extension
extension MoviesViewModel {

    func fetchMoreMovies() {
        if search.value.text.isEmpty {
            fetchNowPlaying()
        } else {
            searchMovies(for: search.value.text)
        }
    }

    func fetchNowPlaying(
        isInitialLoad: Bool = false
    ) {
        if isInitialLoad {
            currentPage.value = 0
            movies.value = []
            search.value = (page: 0, text: "")
        }
        fetchNowPlaying(page: currentPage.value + 1) { moviesHandler in
            switch moviesHandler {
            case let .success(moviesResult):
                self.currentPage.value += 1
                self.movies.value.append(moviesResult)
            case let .failure(error):
                print(error)
            }
        }
    }

    func searchMovies(
        for text: String = ""
    ) {
        search.value.text = text
        if text.isEmpty {
            fetchNowPlaying(isInitialLoad: true)
        } else {
            if search.value.page == 0 {
                movies.value = []
            }
            searchMovies(for: text, page: search.value.page + 1) { moviesHandler in
                switch moviesHandler {
                    case let .success(moviesResult):
                        self.search.value.page += 1
                        self.movies.value.append(moviesResult)
                    case let .failure(error):
                        print(error)
                }
            }
        }
    }
}

// MARK:- Private extension
private extension MoviesViewModel {
    func fetchNowPlaying(
        for text: String = "",
        page: Int = 1,
        moviesHandler: @escaping (Result<Movies.SearchResults, MoviesError>) -> Void
    ) {
        let searchDispose = searchRequest.fetchNowPlaying(text: text, page: page)
            .observe(on: QueueScheduler.main)
            .startWithResult { result in
               moviesHandler(result)
        }
        disposableBag.add(searchDispose)
    }
}

private extension MoviesViewModel {
    func searchMovies(
        for text: String = "",
        page: Int = 1,
        moviesHandler: @escaping (Result<Movies.SearchResults, MoviesError>) -> Void
    ) {
        let searchDispose = searchRequest.search(text: text, page: page)
            .observe(on: QueueScheduler.main)
            .startWithResult { result in
               moviesHandler(result)
        }
        disposableBag.add(searchDispose)
    }
}
