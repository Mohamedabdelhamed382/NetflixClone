//
//  Movie.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 26/03/2022.
//

import Foundation
// MARK: - TrendingMovieResponse
struct TrendingTitlesResponse: Codable {
    var page: Int?
    var results: [Titles]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages
        case totalResults
    }
}

// MARK: - Result
struct Titles: Codable {
    var originalLanguage, posterPath, firstAirDate: String?
    var id: Int?
    var overview: String?
    var voteCount: Int?
    var voteAverage: Double?
    var genreIDS: [Int]?
    var name, backdropPath, originalName: String?
    var originCountry: [String]?
    var popularity: Double?
    var mediaType: String?
    var originalTitle: String?
    var video: Bool?
    var releaseDate, title: String?
    var adult: Bool?

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case posterPath = "poster_path" 
        case firstAirDate
        case id, overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case genreIDS
        case name
        case backdropPath
        case originalName = "original_name"
        case originCountry
        case popularity
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case video
        case releaseDate
        case title, adult
    }
}



// MARK: - ErrorResponse
struct ErrorResponse: Codable,Error {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
