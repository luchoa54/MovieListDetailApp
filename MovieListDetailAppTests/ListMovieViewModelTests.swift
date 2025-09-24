//
//  ListMovieViewModelTests.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import XCTest
import RxSwift
@testable import MovieListDetailApp

final class ListMovieViewModelTests: XCTestCase {

    var viewModel: ListMovieViewModel!
    var mockMovieService: MockListMovieService!
    var mockGenreService: MockGenreMovieService!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        mockMovieService = MockListMovieService()
        mockGenreService = MockGenreMovieService()
        viewModel = ListMovieViewModel(listMovieService: mockMovieService, genreService: mockGenreService)
        disposeBag = DisposeBag()
    }

    func test_fetchMovies_success() {
        let genre = Genre(id: 1, name: "Action")
        mockGenreService.genresToReturn = [genre]

        let movie = MovieModel(id: 1, originalTitle: "Test Movie", backdropPath: nil, posterPath: nil, releaseDate: "2025-09-23", video: false, genre_ids: [1])
        let moviesWrapper = Movies(results: [movie])
        mockMovieService.moviesToReturn = [moviesWrapper]

        let expectation = XCTestExpectation(description: "Movies fetched successfully")

        viewModel.state
            .skip(1)
            .subscribe(onNext: { state in
                switch state {
                case .success(let movies):
                    // Assert
                    XCTAssertEqual(movies.count, 1)
                    XCTAssertEqual(movies.first?.originalTitle, "Test Movie")
                    XCTAssertEqual(movies.first?.genreNames?.first, "Action")
                    expectation.fulfill()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        viewModel.fetchMovies()

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchMovies_failure_genreService() {
        mockGenreService.shouldFail = true
        let expectation = XCTestExpectation(description: "Fetch fails due to genre service")

        viewModel.state
            .skip(1)
            .subscribe(onNext: { state in
                switch state {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        viewModel.fetchMovies()

        wait(for: [expectation], timeout: 1.0)
    }
}
