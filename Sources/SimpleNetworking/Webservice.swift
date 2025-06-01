//
//  Webservice.swift
//  PetAdoptioin
//
//  Created by ebrahim.badawy on 01/06/2025.
//

import Foundation

enum NetworkError: Error {
    case badrequest
    case decodingError
}

class Webservice {
    
    func fetch<T: Codable>(url: URL, parse: @escaping (Data)->T, completion: @escaping (Result<T, NetworkError>)->Void){
        URLSession.shared.dataTask(with: url) { data,response,error in
            guard let data = data, error == nil,
            (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(.decodingError))
                return
            }
            let result = parse(data)
            completion(.success(result))
            
        }.resume()
    }
    
}
