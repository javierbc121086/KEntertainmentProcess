//
//  KMovieResponseEntity.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

struct KMovieResponseEntity: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [KMovieEntity]
}
