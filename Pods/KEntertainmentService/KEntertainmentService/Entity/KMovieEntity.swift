//
//  KMovieEntity.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

struct KMovieEntity: Codable {
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var posterPath: String?
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var originalLanguage: String
    var originalTitle: String
    var genreIds: [Int]
    var title: String
    var voteAverage: Double // Revisar el valor int
    var overview: String
    var releaseDate: String?
}
