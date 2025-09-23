//
//  GenreMovieService.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//

import Foundation

protocol GenreMovieServiceProtocol {
    func listGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}

class GenreMovieService: GenreMovieServiceProtocol {
    func listGenres(completion: @escaping (Result<[Genre], any Error>) -> Void) {
        guard let url = URL(string: APIConstants.genreURL) else { return }
        
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
                        let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
                        completion(.success(genreResponse.genres))
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
