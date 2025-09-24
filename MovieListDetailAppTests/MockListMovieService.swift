//
//  MockListMovieService.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation
@testable import MovieListDetailApp

class MockListMovieService: ListMovieServiceProtocol {
    var shouldFail = false
    var moviesToReturn: [Movies] = []
    
    func getSimilarMovies(completion: @escaping (Result<[Movies], Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "Test", code: 1)))
        } else {
            completion(.success(moviesToReturn))
        }
    }
    
    func getSimilarMovies(for movieId: Int, completion: @escaping (Result<[Movies], Error>) -> Void) {
        getSimilarMovies(completion: completion)
    }
}

class MockGenreMovieService: GenreMovieServiceProtocol {
    var shouldFail = false
    var genresToReturn: [Genre] = []
    
    func listGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "Test", code: 1)))
        } else {
            completion(.success(genresToReturn))
        }
    }
}
