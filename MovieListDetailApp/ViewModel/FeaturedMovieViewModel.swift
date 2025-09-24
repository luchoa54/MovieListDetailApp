//
//  FeaturedMovieViewModel.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation
import RxSwift
import RxCocoa

class FeaturedMovieViewModel {
    private var featuredMovieService: FeaturedMovieServiceProtocol
    public let posterData: PublishSubject<Data> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    public static let shared = FeaturedMovieViewModel(featuredMovieService: FeaturedMovieService())
    
    public let state: BehaviorSubject<ViewModelState<[FeaturedMovieModel]>> = BehaviorSubject(value: .idle)
    
    init(featuredMovieService: FeaturedMovieServiceProtocol) {
        self.featuredMovieService = featuredMovieService
    }
    
    public func formatLikeNumber(_ voteCount: Int) -> String{
        if voteCount < 999 {
            return "\(String(voteCount)) Likes"
        }
        if voteCount > 999 && voteCount < 999999 {
            return "\(self.formatNumberToDecimal(value: Double(voteCount)))K Likes"
        }
        if voteCount > 999999 {
            return "\(self.formatNumberToDecimal(value: Double(voteCount)))M Likes"
        }
        return ""
    }
    
    public func formatViewNumber(_ popularityViews: Double) -> String{
        let popularity = NSString(format: "%.1f", popularityViews)
        if popularityViews < 999 {
            return "\(String(popularity))K Views"
        }
        if popularityViews > 999 && popularityViews < 999999 {
            return "\(String(popularity))K Views"
        }
        if popularityViews > 999999 {
            return "\(String(popularity))M Views"
        }
        return ""
    }
    
    private func formatNumberToDecimal(value: Double) -> String {
        let adjustedValue: Double
        if value >= 1000 {
            adjustedValue = value / 1000.0
        } else {
            adjustedValue = value
        }
        
        let roundedValue = Double(Int(adjustedValue * 10)) / 10.0
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        let formattedValue = numberFormatter.string(from: NSNumber(value: roundedValue)) ?? "Undefined"
        
        return formattedValue
    }
    
    public func fetchFeaturedMovie(for movieId: Int) {
        state.onNext(.loading)
        
        featuredMovieService.getMovieDetails(for: movieId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let movie):
                        self.state.onNext(.success([movie]))
                    case .failure(let error):
                        self.state.onNext(.failure(error))
                }
            }
        }
    }
    
    public func fetchPoster(for url: String) {
        featuredMovieService.fetchMoviePoster(url: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        self.posterData.onNext(data)
                    case .failure(let error):
                        print("Failed to fetch poster:", error.localizedDescription)
                }
            }
        }
    }
}
