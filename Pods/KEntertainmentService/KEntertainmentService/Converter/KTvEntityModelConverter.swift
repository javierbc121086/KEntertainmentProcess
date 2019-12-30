//
//  KTvEntityModelConverter.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain

struct KTvEntityModelConverter {
    public static func entityToModel(entity: KTvEntity) -> KTvModel {
        let model = KTvModel(
                id: entity.id,
                originalName: entity.originalName,
                genreIds: entity.genreIds,
                name: entity.name,
                popularity: entity.popularity,
                originCountry: entity.originCountry,
                voteCount: entity.voteCount,
                firstAirDate: entity.firstAirDate,
                backdropPath: entity.backdropPath ?? .Empty,
                originalLanguage: entity.originalLanguage,
                voteAverage: entity.voteAverage,
                overview: entity.overview,
                posterPath: entity.posterPath ?? .Empty
        )

        return model
    }
}
