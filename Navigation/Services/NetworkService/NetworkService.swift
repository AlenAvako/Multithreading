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
    
    func testRequest(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/5") else { return }
        let request = URLRequest(url: url)
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func planetRequest(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        let request = URLRequest(url: url)
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func personRequest(person: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: person) else { return }
        let request = URLRequest(url: url)
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
