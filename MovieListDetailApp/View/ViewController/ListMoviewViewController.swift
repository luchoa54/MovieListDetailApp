//
//  ViewController.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//

import UIKit
import RxSwift
import RxCocoa

class ListMoviewViewController: UIViewController {
    
    private let listMovieView = ListMovieView()
    private let similarFilmViewModel = ListMovieViewModel.shared
    private let featuredMovieViewModel = FeaturedMovieViewModel.shared
    private let disposeBag = DisposeBag()
    private var animatedIndexPaths: Set<IndexPath> = []
    
    private var selectedMovieId: Int = APIConstants.initialMovieId
    
    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = listMovieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSimilarViewModel()
        configureTableHeaderView()
        configurePullToRefresh()
        fetchMovieData()
    }
    
    private func configurePullToRefresh() {
        listMovieView.refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }

    @objc private func handlePullToRefresh() {
        similarFilmViewModel.fetchMovies(for: selectedMovieId)
        featuredMovieViewModel.fetchFeaturedMovie(for: selectedMovieId)
    }
    
    private func fetchMovieData() {
        similarFilmViewModel.fetchMovies(for: selectedMovieId)
        featuredMovieViewModel.fetchFeaturedMovie(for: selectedMovieId)
    }
    
    private func configureTableHeaderView() {
        let headerView = HeaderMovieView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: UIScreen.main.bounds.height / 2))
        listMovieView.tableView.tableHeaderView = headerView
        configureHeaderBinding(headerView: headerView)
    }
    
    private func configureHeaderBinding(headerView: HeaderMovieView) {
        featuredMovieViewModel.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .success(let movie):
                        if let featuredMovie = movie.first {
                            headerView.isLiked = false
                            headerView.configureHeader(with: featuredMovie)
                            headerView.likeLabel.text = "\(self.featuredMovieViewModel.formatLikeNumber(featuredMovie.voteCount))"
                            headerView.viewsLabel.text = "\(self.featuredMovieViewModel.formatViewNumber(featuredMovie.popularity))"
                            self.featuredMovieViewModel.fetchPoster(for: featuredMovie.posterPath!)
                        }
                    case .failure(let error):
                        print("\(error)")
                    default:
                        break
                }
            })
            .disposed(by: disposeBag)
        
        featuredMovieViewModel.posterData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                headerView.imageView.image = UIImage(data: data)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Binding
    private func bindSimilarViewModel() {
        similarFilmViewModel.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                self.handleState(state)
            })
            .disposed(by: disposeBag)
        listMovieView.tableView.rx.modelSelected(MovieModel.self)
            .subscribe(onNext: { [weak self] movie in
                guard let self else { return }
                
                FeaturedMovieService().getMovieDetails(for: movie.id) { result in
                    switch result {
                        case .success(let detailedMovie):
                            let detailVC = MovieDetailViewController(movie: detailedMovie)
                            self.navigationController?.pushViewController(detailVC, animated: true)
                            if let selectedIndexPath = self.listMovieView.tableView.indexPathForSelectedRow {
                                self.listMovieView.tableView.deselectRow(at: selectedIndexPath, animated: true)
                            }
                        case .failure(let error):
                            print("Erro ao carregar detalhes: \(error)")
                    }
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func handleState(_ state: ViewModelState<[MovieModel]>) {
        switch state {
            case .idle:
                listMovieView.loadingIndicator.stopAnimating()
                listMovieView.errorLabel.isHidden = true
                listMovieView.refreshControl.endRefreshing()
            case .loading:
                listMovieView.loadingIndicator.startAnimating()
                listMovieView.errorLabel.isHidden = true
            case .success(let movies):
                listMovieView.loadingIndicator.stopAnimating()
                listMovieView.errorLabel.isHidden = true
                listMovieView.refreshControl.endRefreshing()
                updateTableView(with: movies)
            case .failure(let error):
                listMovieView.loadingIndicator.stopAnimating()
                listMovieView.errorLabel.text = error.localizedDescription
                listMovieView.errorLabel.isHidden = false
                listMovieView.refreshControl.endRefreshing()
        }
    }
    
    private func updateTableView(with movies: [MovieModel]) {
        listMovieView.tableView.dataSource = nil
        Observable.just(movies)
            .bind(to: listMovieView.tableView.rx.items(cellIdentifier: ListMovieCellView.cellIdentifier, cellType: ListMovieCellView.self)) { index, movie, cell in
                cell.configure(with: movie)
            }
            .disposed(by: disposeBag)
    }
}

