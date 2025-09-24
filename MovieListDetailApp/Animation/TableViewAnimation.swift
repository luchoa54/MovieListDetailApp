//
//  TableViewAnimation.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import UIKit

typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

class TableViewAnimation {
    private let animation: TableCellAnimation
    
    init(animation: @escaping TableCellAnimation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        animation(cell, indexPath, tableView)
    }
}

enum TableViewAnimationType {
    
    static func fadeIn(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.alpha = 0
            UIView.animate(withDuration: duration, delay: delayFactor * Double(indexPath.row), animations: {
                cell.alpha = 1
            })
        }
    }
}
