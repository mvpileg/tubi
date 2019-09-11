//
//  MovieItem.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

struct MovieItem: Codable {
    let title: String
    let image: String
    let id: String
    let index: Int?
}
