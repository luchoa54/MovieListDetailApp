//
//  MovieCell.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//

import UIKit

class ListMovieCellView: UITableViewCell {
    
    static let cellIdentifier = "MovieCell"
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Colors.textColor
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.detailsLabelColor
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.detailsLabelColor
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .default
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - View Setup
    private func setupView() {
        self.backgroundColor = Colors.backgroundColor
        contentView.addSubview(posterImageView)
        contentView.addSubview(textStackView)
        
        textStackView.addArrangedSubview(titleLabel)
        
        horizontalStackView.addArrangedSubview(releaseYearLabel)
        horizontalStackView.addArrangedSubview(genresLabel)
        textStackView.addArrangedSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: 60),
            posterImageView.heightAnchor.constraint(equalToConstant: 70),
            
            textStackView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            textStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            textStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            textStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(with movie: MovieModel) {
        titleLabel.text = movie.originalTitle
        titleLabel.accessibilityIdentifier = "movieTitle_\(movie.id)"
        
        if let releaseDate = movie.releaseDate {
            releaseYearLabel.text = extractYear(from: releaseDate)
        }
        
        if let genres = movie.genreNames, !genres.isEmpty {
            let limitedGenres = genres.prefix(3)
            genresLabel.text = limitedGenres.joined(separator: ", ")
        } else {
            genresLabel.text = "No Genre"
        }
        
        if let posterURL = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w185\(posterURL)") {
            downloadImage(from: url)
        }
    }
    
    private func extractYear(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
        }.resume()
    }
}
