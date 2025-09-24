//
//  Colors.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import UIKit

class Colors {
    
    static let backgroundColor: UIColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
    
    static let textColor: UIColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
    }
    
    static let detailsLabelColor: UIColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .lightGray : .darkGray
    }
}