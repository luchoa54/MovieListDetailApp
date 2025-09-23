//
//  MovieModel.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation

struct Movies: Decodable {
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MovieModel: Decodable {
    let id: Int
    let originalTitle: String
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    var video: Bool
    let genre_ids: [Int]
    var genreNames: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case video
        case genre_ids
    }
}

