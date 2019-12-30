//
//  KBaseService.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import GNNetworkServices

/**
 Protocolo base que hereda la funcioanlidad del core GNNetworkServices
 
 ## Nota ##
 Todos los protocolos que hereden de **KBaseServiceDelegate**
 y sean implementados sobre su clase, estructura o enumeracion
 deberan asignar un valos a la propiedad **delegate**, de lo contrario
 no podran obtener las respuestas del core service por medio del patron delegado
 */
public protocol KBaseServiceDelegate: GNBaseServiceDelegate { }

/**
 Clase base que hereda la funcioanlidad del core GNNetworkServices
 
 ## Nota ##
 Todas las clases que hereden de **KBaseService** deberan asignar un valos a la
 propiedad **delegate**, de lo contrario no podran obtener las respuestas del core service
 */
public class KBaseService: GNBaseService { }
