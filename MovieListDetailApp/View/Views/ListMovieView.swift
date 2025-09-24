//
//  ListMovieView.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//

import Foundation
import UIKit

class ListMovieView: UIView, UITableViewDelegate, ViewCode {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListMovieCellView.self, forCellReuseIdentifier: ListMovieCellView.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        tableView.backgroundColor = Colors.backgroundColor
        tableView.sectionFooterHeight = 6
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        return tableView
    }()

    let refreshControl : UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.accessibilityIdentifier = "refreshControl"
        return refresh
    }()

    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private var animatedIndexPaths: Set<IndexPath> = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureTableView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        configureTableView()
    }

    func setupHierarchy() {
        addSubview(tableView)
        addSubview(loadingIndicator)
        addSubview(errorLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.refreshControl = refreshControl
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !animatedIndexPaths.contains(indexPath) {
            animatedIndexPaths.insert(indexPath)

            let animation = TableViewAnimationType.fadeIn(duration: 0.55, delayFactor: 0.1)
            let animator = TableViewAnimation(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = tableView.tableHeaderView as? HeaderMovieView else { return }

        let offsetY = scrollView.contentOffset.y

        if offsetY < 0 {
            headerView.imageViewHeight.constant = headerView.containerViewHeight.constant - offsetY
            headerView.imageViewBottom.constant = 0
        } else {
            headerView.imageViewHeight.constant = headerView.containerViewHeight.constant
            headerView.imageViewBottom.constant = -offsetY / 2
        }
    }
}

