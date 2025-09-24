//
//  APIConstants.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation

class APIConstants {
    
    static let acceptType = "application/json"
    static let initialMovieId = 1061474
    
    /*
     NOTE: For this test project, the API token is intentionally left as a placeholder.
     This decision was made to:
     
     1. Avoid committing sensitive API keys to a public repository.
     2. Make it clear that in a real project, keys should be handled securely
     3. Allow the reviewer to use their own personal TMDB token to run the project.
     */
    static var authorization: String {
        return "Bearer YOUR_API_KEY" // Replace with your personal TMDB token
    }
    
    static let language = "en-US"
    
    static let similarMoviesURL = "https://api.themoviedb.org/3/movie/"
    static let movieDetailURL = "https://api.themoviedb.org/3/movie/"
    static let moviePosterURL = "https://image.tmdb.org/t/p/w500"
    static let genreURL = "https://api.themoviedb.org/3/genre/movie/list"
}
