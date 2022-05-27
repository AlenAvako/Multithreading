//
//  NetworkService.swift
//  Navigation
//
//  Created by Ален Авако on 20.04.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    
     case one = "https://swapi.dev/api/people/8"
     case two = "https://swapi.dev/api/starships/3"
     case three = "https://swapi.dev/api/planets/5"
 }

struct NetworkService {
    
    func urlSessionDataTask(caseURL: AppConfiguration) {
        
        let url = caseURL
        guard let urlRawValue = URL(string: url.rawValue) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: urlRawValue) { data, response, error in
            if let response = response {
                print("RESPONSE")
                print(response)
            }
            
            guard let data = data else { return }
            let stringData = String(decoding: data, as: UTF8.self)
            print("DATA")
            print(stringData)
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("\n AllHeaderFields - \(httpResponse.allHeaderFields)")
                print("\n StatusCode - \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
}
