
//
//  FeaturedMovieService.swift
//  ToDoMoviesDimensa
//
//  Created by Luciano Uchoa on 19/01/25.
//

import Foundation

protocol FeaturedMovieServiceProtocol {
    func fetchMoviePoster(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func getMovieDetails(for movieId: Int, completion: @escaping (Result<FeaturedMovieModel, Error>) -> Void)
}

class FeaturedMovieService: FeaturedMovieServiceProtocol {
    func getMovieDetails(for movieId: Int, completion: @escaping (Result<FeaturedMovieModel, Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.movieDetailURL)\(movieId)") else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "language", value: APIConstants.language)]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": APIConstants.acceptType,
            "Authorization": APIConstants.authorization
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            DispatchQueue.main.async {
                do {
                    let featuredMovie = try JSONDecoder().decode(FeaturedMovieModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(featuredMovie))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchMoviePoster(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.moviePosterURL)\(url)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
