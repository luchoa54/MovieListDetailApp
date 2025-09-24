//
//  MovieDetailViewController.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import UIKit

class MovieDetailViewController: UIViewController {
    
    private let viewModel: MovieDetailViewModel
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel = UILabel()
    private let taglineLabel = UILabel()
    private let ratingLabel = UILabel()
    
    private let infoContainer = UIView()
    private let infoTitleLabel = UILabel()
    private let infoLabel = UILabel()
    
    private let overviewLabel = UILabel()
    
    // MARK: - Init
    init(movie: FeaturedMovieModel) {
        self.viewModel = MovieDetailViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        view.accessibilityIdentifier = "MovieDetailView"
        setupLayout()
        configureUI()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.alignment = .fill
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        contentView.addArrangedSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        [titleLabel, taglineLabel, ratingLabel].forEach { label in
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addArrangedSubview(titleLabel)
        overviewLabel.numberOfLines = 0
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(overviewLabel)
        
        contentView.addArrangedSubview(taglineLabel)
        contentView.addArrangedSubview(ratingLabel)
        
        infoContainer.backgroundColor = UIColor.secondarySystemBackground
        infoContainer.layer.cornerRadius = 12
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        
        infoTitleLabel.font = .boldSystemFont(ofSize: 18)
        infoTitleLabel.textColor = Colors.textColor
        infoTitleLabel.text = "Movie Info"
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = Colors.detailsLabelColor
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoContainer.addSubview(infoTitleLabel)
        infoContainer.addSubview(infoLabel)
        
        contentView.addArrangedSubview(infoContainer)
        
        NSLayoutConstraint.activate([
            infoTitleLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 10),
            infoTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 10),
            infoTitleLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -10),
            
            infoLabel.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -10),
            infoLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = Colors.textColor
        titleLabel.text = viewModel.title
        
        taglineLabel.font = .italicSystemFont(ofSize: 16)
        taglineLabel.textColor = Colors.detailsLabelColor
        taglineLabel.text = viewModel.tagline
        
        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textColor = Colors.detailsLabelColor
        ratingLabel.text = viewModel.ratingText
        
        infoLabel.text = viewModel.infoText
        
        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.textColor = Colors.textColor
        overviewLabel.text = viewModel.overview
        overviewLabel.accessibilityIdentifier = "overviewLabelIdentifier"
        
        if let url = viewModel.posterURL() {
            downloadImage(from: url)
        }
    }
    
    // MARK: - Image Download
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
        }.resume()
    }
}
