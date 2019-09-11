//
//  Router.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

enum Router {
    
    case getMovieList
    case getMovieDetails(String)
    
    var url: URL? {
        return URL(string: "https://\(host)/\(path)")
    }
    
    private static let moviesResourcePath = "api/movies"
    
    private var host: String {
        return "us-central1-modern-venture-600.cloudfunctions.net"
    }
    
    private var path: String {
        switch self {
        case .getMovieList:
            return Router.moviesResourcePath
        case .getMovieDetails(let id):
            return "\(Router.moviesResourcePath)/\(id)"
        }
    }
}

