//
//  TestInfoModel.swift
//  Navigation
//
//  Created by Ален Авако on 20.04.2022.
//

import Foundation

struct TestInfoModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
