//
//  PlanetModel.swift
//  Navigation
//
//  Created by Ален Авако on 20.04.2022.
//

import Foundation

struct PlanetModel: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let residents: [String]
}
