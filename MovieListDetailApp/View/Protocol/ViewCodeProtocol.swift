//
//  ViewCode.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import Foundation

protocol ViewCode {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
}
