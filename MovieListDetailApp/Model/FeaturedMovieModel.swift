//
//  FeaturedMovieModel.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation

//Filme que ficará em foco na tela
struct FeaturedMovieModel: Decodable, @unchecked Sendable {
    let id: Int
    let originalTitle: String
    let posterPath: String?
    var popularity: Double
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case popularity
        case voteCount = "vote_count"
    }
}
