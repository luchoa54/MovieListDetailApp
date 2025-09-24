//
//  ViewModelState.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


enum ViewModelState<T> {
    case idle
    case loading
    case success(T)
    case failure(Error)
}