//
//  KServiceConfig.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import GNNetworkServices

public struct KServiceConfig {
    /**
     MOVIE
     */
    public static let movie_popular
        = GNDependencySeriveConfig.GetIdentifierRestServer.getUrl().appending("/4/discover/movie?sort_by=popularity.desc")
    public static let movie_rated
        = GNDependencySeriveConfig.GetIdentifierRestServer.getUrl().appending("/4/discover/movie/?sort_by=vote_average.desc")
    public static let movie_upcoming
        = GNDependencySeriveConfig.GetIdentifierRestServer.getUrl().appending("/3/movie/upcoming?api_key=%@")
    
    /**
     TV
     */
    public static let tv_popular
        = GNDependencySeriveConfig.GetIdentifierRestServer.getUrl().appending("/3/tv/popular?api_key=%@")
    public static let tv_rated
        = GNDependencySeriveConfig.GetIdentifierRestServer.getUrl().appending("/3/tv/top_rated?api_key=%@")
    public static let tv_upcoming
        = GNDependencySeriveConfig.GetIdentifierRestServer.getUrl().appending("/3/discover/tv?api_key=%@&air_date.gte=%@")
}
