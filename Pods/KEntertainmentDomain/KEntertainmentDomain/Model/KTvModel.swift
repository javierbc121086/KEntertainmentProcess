//
//  KTvModel.swift
//  KEntertainmentDomain
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

public struct KTvModel {
    
    public var id: Int
    public var originalName: String
    public var genreIds: [Int]
    public var name: String
    public var popularity: Double
    public var originCountry: [String]
    public var voteCount: Int
    public var firstAirDate: String
    public var backdropPath: String
    public var originalLanguage: String
    public var voteAverage: Double
    public var overview: String
    public var posterPath: String
    
    public var cacheData: Any? = nil
    public var isVerified = false
    
    public init (id: Int,
                 originalName: String,
                 genreIds: [Int],
                 name: String,
                 popularity: Double,
                 originCountry: [String],
                 voteCount: Int,
                 firstAirDate: String,
                 backdropPath: String,
                 originalLanguage: String,
                 voteAverage: Double,
                 overview: String,
                 posterPath: String
    ) {
        self.id                 = id
        self.originalName       = originalName
        self.genreIds           = genreIds
        self.name               = name
        self.popularity         = popularity
        self.originCountry      = originCountry
        self.voteCount          = voteCount
        self.firstAirDate       = firstAirDate
        self.backdropPath       = backdropPath
        self.originalLanguage   = originalLanguage
        self.voteAverage        = voteAverage
        self.overview           = overview
        self.posterPath         = posterPath
    }
}
