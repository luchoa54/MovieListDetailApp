//
//  ListMovieViewModel.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation
import RxSwift
import RxCocoa

class ListMovieViewModel {
    private var listMovieService: ListMovieServiceProtocol
    private var genreService: GenreMovieServiceProtocol
    private var genres: [Genre] = []
    private let disposeBag = DisposeBag()
    
    public static let shared = ListMovieViewModel(listMovieService: ListMovieService(), genreService: GenreMovieService())
    
    public let state: BehaviorSubject<ViewModelState<[MovieModel]>> = BehaviorSubject(value: .idle)
    
    init(listMovieService: ListMovieServiceProtocol, genreService: GenreMovieServiceProtocol) {
        self.listMovieService = listMovieService
        self.genreService = genreService
    }
    
    public func fetchMovies() {
        state.onNext(.loading)
        
        genreService.listGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genres):
                self.genres = genres
                self.fetchMoviesWithGenres()
            case .failure(let error):
                self.state.onNext(.failure(error))
            }
        }
    }
    
    private func fetchMoviesWithGenres() {
        listMovieService.getSimilarMovies { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    let moviesWithGenres = self.mapGenres(to: movies[0].results)
                    self.state.onNext(.success(moviesWithGenres))
                case .failure(let error):
                    self.state.onNext(.failure(error))
                }
            }
        }
    }
    
    private func mapGenres(to movies: [MovieModel]) -> [MovieModel] {
        return movies.map { movie in
            var updatedMovie = movie
            updatedMovie.genreNames = movie.genre_ids.compactMap { id in
                genres.first(where: { $0.id == id })?.name
            }
            return updatedMovie
        }
    }
    
    public func fetchMovies(for movieId: Int) {
        state.onNext(.loading)
        
        genreService.listGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genres):
                self.genres = genres
                self.fetchMoviesWithGenres(for: movieId)
            case .failure(let error):
                self.state.onNext(.failure(error))
            }
        }
    }
    
    private func fetchMoviesWithGenres(for movieId: Int) {
        listMovieService.getSimilarMovies(for: movieId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    let moviesWithGenres = self.mapGenres(to: movies[0].results)
                    self.state.onNext(.success(moviesWithGenres))
                case .failure(let error):
                    self.state.onNext(.failure(error))
                }
            }
        }
    }
}

