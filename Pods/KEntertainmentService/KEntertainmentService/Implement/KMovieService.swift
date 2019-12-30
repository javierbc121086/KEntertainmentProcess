//
//  KMovieService.swift
//  KEntertainmentService
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import GNSwissRazor
import KEntertainmentDomain

/**
 Protocolo encargado de extender el la funcionalidad
 base de KBaseServiceDelegate
 
 ## Funcionalidad ##
 **dataResponseService::response::type** es responsable de proveer información
 valida si la peticion al webservice **Movies**, es satisfactoria
 */
public protocol KMovieServiceDelegate: KBaseServiceDelegate {
    func dataResponseService(response: [KMovieModel], type: KHttpRequestType)
}

/**
 Clase manejadora que se encarga de heredar y procesar las respuestas del ámbito Movies
 */
public class KMovieService: KBaseService {
    
    /**
     Propiedad encargada de castear el protocolo base al comportamiento del ámbito Movies,
     extendiendo la informacion que podemos recuperar del webservice
     */
    private var movieServiceDelegate: KMovieServiceDelegate? {
        return self.delegate as? KMovieServiceDelegate
    }
    
    /**
     Sobre escritura del comportamiento **parseJson:uniqueIdentifierFlow:rawDic**
     encargada de recibir la respuesta satiscaftoria del webservice
     
     - Parameter uniqueIdentifierFlow: Identificador unico al cual pertenece la peticion (dentro de un grupo de flujos).
     - Parameter rawDic: Diccionario que nos permite recibir la respuesta del servidor en formato llave - valor.
     */
    override public func parseJson(uniqueIdentifierFlow: Int, rawDic: NSDictionary) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let theJSONData = try? JSONSerialization.data(withJSONObject: rawDic, options: []) {
                let decoded = try decoder.decode(KMovieResponseEntity.self, from: theJSONData)
                var list: [KMovieModel] = []
                decoded.results.forEach { list.append(KMovieEntityModelConverter.entityToModel(entity: $0)) }
                self.movieServiceDelegate?.dataResponseService(
                        response: list,
                        type: KHttpRequestType(rawValue: uniqueIdentifierFlow) ?? .none
                )
            }
        }
        catch let error {
            self.delegate?.requestFailWithError(
                error: GNTools.MakeError(
                    message: """
                             KMovieService Error: el formato de respuesta es inválido
                             \(rawDic)
                             \n
                             \(error.localizedDescription)
                             """
                )
            )
        }
    }
}
