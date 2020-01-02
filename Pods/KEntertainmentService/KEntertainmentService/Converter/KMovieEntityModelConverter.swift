//
//  KMovieEntityModelConverter.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain

struct KMovieEntityModelConverter {

    static func entityToModel(entity: KMovieEntity) -> KMovieModel {
        let model = KMovieModel(
            id: entity.id,
            popularity: entity.popularity,
            voteCount: entity.voteCount,
            video: entity.video,
            adult: entity.adult,
            originalLanguage: entity.originalLanguage,
            originalTitle: entity.originalTitle,
            genreIds: entity.genreIds,
            title: entity.title,
            voteAverage: entity.voteAverage,
            overview: entity.overview,
            releaseDate: entity.releaseDate ?? .Empty,
            backdropPath: entity.backdropPath ?? .Empty,
            posterPath: entity.posterPath ?? .Empty,
            requestType: -1
        )
        
        return model
    }
}
