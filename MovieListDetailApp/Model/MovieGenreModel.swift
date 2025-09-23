//
//  MovieGenreModel.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

