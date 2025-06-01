//
//  Webservice.swift
//  PetAdoptioin
//
//  Created by ebrahim.badawy on 01/06/2025.
//

import Foundation

public enum NetworkError: Error {
    case badrequest
    case decodingError
}

public class Webservice {
    public init(){
        
    }
    public func fetch<T: Codable>(url: URL, parse: @Sendable @escaping (Data) -> T,
                           completion: @Sendable @escaping (Result<T?, NetworkError>) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
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
