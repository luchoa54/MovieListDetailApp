//
//  MovieDetailViewModel.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import UIKit

// MARK: - ViewModel
class MovieDetailViewModel {
    private let movie: FeaturedMovieModel
    
    init(movie: FeaturedMovieModel) {
        self.movie = movie
    }
    
    var title: String { movie.title }
    var tagline: String { movie.tagline?.isEmpty == false ? "“\(movie.tagline!)”" : "" }
    var overview: String { movie.overview ?? "No overview available." }
    
    var ratingText: String {
        let formattedVote = String(format: "%.1f", movie.voteAverage)
        return "Rating: \(formattedVote) (\(movie.voteCount) votes) | Runtime: \(movie.runtime ?? 0) min"
    }

    var infoText: String {
        let genres = movie.genres.map { $0.name }.joined(separator: ", ")
        let companies = movie.productionCompanies.map { $0.name }.joined(separator: ", ")
        let countries = movie.productionCountries.map { $0.name }.joined(separator: ", ")
        return """
        Release: \(extractYear(from: movie.releaseDate))
        Status: \(movie.status ?? "-")
        Budget: $\(movie.budget) | Revenue: $\(movie.revenue)
        Production: \(companies)
        Countries: \(countries)
        Genres: \(genres)
        """
    }
    
    func posterURL() -> URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    private func extractYear(from date: String?) -> String {
        guard let date = date else { return "-" }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        if let date = df.date(from: date) {
            df.dateFormat = "yyyy"
            return df.string(from: date)
        }
        return "-"
    }
}
