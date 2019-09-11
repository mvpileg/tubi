//
//  CacheProvider.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/10/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

class CacheProvider {
    
    static let movieItemCache = LRUCache<String, MovieItem>(capacity: 5)
    
}
