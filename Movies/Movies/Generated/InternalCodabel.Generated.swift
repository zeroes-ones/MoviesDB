//
//  InternalCodabel.Generated.swift
//  Movies
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
extension Movies {
    struct Movie: Codable, Equatable {
        let adult: Bool?
        let backDropPath: String?
        let genreIDs: [Int]?
        let id: Int?
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let popularity: Double?
        let posterPath: String?
        let releaseDate: String?
        let title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        var posterURL: URL? {
            guard let posterPath = posterPath else {
                return nil
            }
            return URL(string: API.posterURL + posterPath)
        }
    }

    struct Dates: Codable, Equatable {
        let maximum: Date?
        let minimum: Date?
    }
}


/// Boiler Plate code for encoding and decoding, we can use `Soucery` framework to generate the models and avoid writing boiler plate code
extension Movies.Movie {
    private enum CodingKeys: String, CodingKey {
        case adult
        case backDropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        backDropPath = try container.decodeIfPresent(String.self, forKey: .backDropPath)
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(adult, forKey: .adult)
        try container.encodeIfPresent(backDropPath, forKey: .backDropPath)
        try container.encodeIfPresent(genreIDs, forKey: .genreIDs)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(originalLanguage, forKey: .originalLanguage)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encodeIfPresent(popularity, forKey: .popularity)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)
    }
}

extension Movies.Dates {
    private enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        maximum = try container.decodeIfPresent(String.self, forKey: .maximum)?.toDate()
        minimum = try container.decodeIfPresent(String.self, forKey: .minimum)?.toDate()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(maximum, forKey: .maximum)
        try container.encodeIfPresent(minimum, forKey: .minimum)
    }
}

extension Movies.SearchResults {
    private enum CodingKeys: String, CodingKey {
        case dates
        case movies = "results"
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dates = try container.decodeIfPresent(Movies.Dates.self, forKey: .dates)
        movies = try container.decodeIfPresent([Movies.Movie].self, forKey: .movies)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(dates, forKey: .dates)
        try container.encodeIfPresent(movies, forKey: .movies)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
    }
}
