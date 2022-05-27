//
//  NetworkDataFetcher.swift
//  Navigation
//
//  Created by Ален Авако on 20.04.2022.
//

import Foundation

class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    
    func testInfoFetcher(completion: @escaping (TestInfoModel?) -> ()) {
        networkService.testRequest { data, error in
            if let error = error {
                print("Error received request data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: TestInfoModel.self, from: data)
            completion(decode)
        }
    }
    
    func planetInfoFetcher(completion: @escaping (PlanetModel?) -> ()) {
        networkService.planetRequest { data, error in
            if let error = error {
                print("Error received request data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PlanetModel.self, from: data)
            completion(decode)
        }
    }
    
    func peopleDataFetcher(person: String, completion: @escaping (PeopleModel?) -> ()) {
        networkService.personRequest(person: person) { data, error in
            if let error = error {
                print("Error received request data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PeopleModel.self, from: data)
            completion(decode)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objetct = try decoder.decode(type, from: data)
            return objetct
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
