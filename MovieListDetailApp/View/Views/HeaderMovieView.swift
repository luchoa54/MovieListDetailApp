//
//  HeaderView.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//

import Foundation
import UIKit

class HeaderMovieView: UIView, ViewCode {
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = Colors.textColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let likeTitleButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.like, for: .normal)
        button.tintColor = Colors.textColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.like, for: .normal)
        button.tintColor = Colors.textColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0M Likes"
        label.textColor = Colors.textColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let eyeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.views
        imageView.tintColor = Colors.textColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let viewsLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0K Views"
        label.textColor = Colors.textColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            Colors.backgroundColor.cgColor
        ]
        gradientLayer.locations = [0.7, 1.0]
        view.layer.addSublayer(gradientLayer)
        return view
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    var isLiked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureLikeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureHeader(with movie: FeaturedMovieModel) {
        updateLikeButtonInage()
        titleLabel.text = movie.originalTitle
        likeLabel.text = "\(movie.voteCount) Likes"
        viewsLabel.text = "\(movie.popularity) Views"
    }
    
    func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(gradientView)
        
        addSubview(titleContainer)
        titleContainer.addArrangedSubview(titleLabel)
        titleContainer.addArrangedSubview(likeTitleButton)
        
        addSubview(likeButton)
        addSubview(likeLabel)
        addSubview(viewsLabel)
        addSubview(eyeImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        containerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            titleContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            likeTitleButton.widthAnchor.constraint(equalToConstant: 20),
            likeTitleButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            likeButton.widthAnchor.constraint(equalToConstant: 16),
            likeButton.heightAnchor.constraint(equalToConstant: 16),
            
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5),
            
            eyeImageView.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            eyeImageView.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 20),
            eyeImageView.widthAnchor.constraint(equalToConstant: 20),
            eyeImageView.heightAnchor.constraint(equalToConstant: 16),
            
            viewsLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            viewsLabel.leadingAnchor.constraint(equalTo: eyeImageView.trailingAnchor, constant: 5)
        ])
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func configureLikeButton() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeTitleButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    @objc private func likeButtonTapped() {
        isLiked.toggle()
        updateLikeButtonInage()
        animateLikeButton()
    }
    
    private func updateLikeButtonInage(){
        if isLiked {
            likeButton.setImage(Images.filledLike, for: .normal)
            likeTitleButton.setImage(Images.filledLike, for: .normal)
        } else {
            likeButton.setImage(Images.like, for: .normal)
            likeTitleButton.setImage(Images.like, for: .normal)
        }
    }
    
    private func animateLikeButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.likeTitleButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.likeButton.transform = CGAffineTransform.identity
                self.likeTitleButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            updateGradientColors()
        }
    }
    
    private func updateGradientColors() {
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                Colors.backgroundColor.cgColor
            ]
        }
    }
}
