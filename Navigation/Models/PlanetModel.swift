//
//  PlanetModel.swift
//  Navigation
//
//  Created by Ален Авако on 20.04.2022.
//

import Foundation

struct PlanetInfo: Decodable {
    let message: String
    let result: Properties
}

struct Properties: Decodable {
    let properties: PlanetModel
}

struct PlanetModel: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
//    let residents: [String]
}
