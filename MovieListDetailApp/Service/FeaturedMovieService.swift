
//
//  FeaturedMovieService.swift
//  ToDoMoviesDimensa
//
//  Created by Luciano Uchoa on 19/01/25.
//

import Foundation

protocol FeaturedMovieServiceProtocol {
    func getMovieDetails(completion: @escaping (Result<[FeaturedMovieModel], Error>) -> Void)
    func fetchMoviePoster(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func getMovieDetails(for movieId: Int, completion: @escaping (Result<[FeaturedMovieModel], Error>) -> Void)

}

class FeaturedMovieService: FeaturedMovieServiceProtocol {
    func getMovieDetails(for movieId: Int, completion: @escaping (Result<[FeaturedMovieModel], any Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.movieDetailURL)\(movieId)") else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: APIConstants.language),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": APIConstants.acceptType,
            "Authorization": APIConstants.authorization
        ]
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let featuredMovie = try JSONDecoder().decode(FeaturedMovieModel.self, from: data)
                        completion(.success([featuredMovie]))
                    } catch {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 400 && response.statusCode <= 500 {
                    completion(.failure(error ?? NSError(domain: "HTTP Error", code: response.statusCode, userInfo: nil)))
                }
            }
        }
        task.resume()
    }
    
    
    func getMovieDetails(completion: @escaping (Result<[FeaturedMovieModel], any Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.movieDetailURL)\(APIConstants.initialMovieId)") else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: APIConstants.language),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": APIConstants.acceptType,
            "Authorization": APIConstants.authorization
        ]
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let featuredMovie = try JSONDecoder().decode(FeaturedMovieModel.self, from: data)
                        completion(.success([featuredMovie]))
                    } catch {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 400 && response.statusCode <= 500 {
                    completion(.failure(error ?? NSError(domain: "HTTP Error", code: response.statusCode, userInfo: nil)))
                }
            }
        }
        task.resume()
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
