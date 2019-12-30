//
//  KTvResponseEntity.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

struct KTvResponseEntity: Codable {
    public var page: Int
    public var totalResults: Int
    public var totalPages: Int
    public var results: [KTvEntity]
}
