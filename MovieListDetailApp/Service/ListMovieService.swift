//
//  ListMovieServiceProtocol.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation

protocol ListMovieServiceProtocol {
    func getSimilarMovies(completion: @escaping (Result<[Movies], Error>) -> Void)
    func getSimilarMovies(for movieId: Int, completion: @escaping (Result<[Movies], Error>) -> Void)
}

class ListMovieService: ListMovieServiceProtocol {
    
    func getSimilarMovies(for movieId: Int, completion: @escaping (Result<[Movies], any Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.similarMoviesURL)\(movieId)/similar") else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: APIConstants.language),
            URLQueryItem(name: "page", value: "1"),
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
                        let movies = try JSONDecoder().decode(Movies.self, from: data)
                        completion(.success([movies]))
                    } catch {
                        print("Failed to decode JSON: \(error)")
                        completion(.failure(error))
                    }
                    
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        guard let error = error else { return }
                        switch response.statusCode {
                            case 400...500:
                                completion(.failure(error))
                            default:
                                break
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    func getSimilarMovies(completion: @escaping (Result<[Movies], any Error>) -> Void) {
        guard let url = URL(string: "\(APIConstants.similarMoviesURL)\(APIConstants.initialMovieId)/similar") else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: APIConstants.language),
            URLQueryItem(name: "page", value: "1"),
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
                        let movies = try JSONDecoder().decode(Movies.self, from: data)
                        completion(.success([movies]))
                    } catch {
                        print("Failed to decode JSON: \(error)")
                        completion(.failure(error))
                    }
                    
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        guard let error = error else { return }
                        switch response.statusCode {
                            case 400...500:
                                completion(.failure(error))
                            default:
                                break
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
