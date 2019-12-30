//
//  KHttpRequestType.swift
//  KEntertainmentDomain
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//


/**
 Enumeracion encargada de proveer valores por tipo de peticiones a webservice.
 
 ## Nota ##
 Se puede presindir de esta enumeracion al usar un cero en el tipo de flujo,
 aunque no se recomienda usar directamente los tipo entero
 */
public enum KHttpRequestType: Int {
    case moviePopularity    = 0
    case movieRate          = 1
    case movieUpcoming      = 2
    case tvPopularity       = 3
    case tvRate             = 4
    case tvUpcoming         = 5
    case none               = 666
}
