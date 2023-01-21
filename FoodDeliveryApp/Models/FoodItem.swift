//
//  FoodItem.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import Foundation

struct Food: Codable {
   
    let name: String
    let price: Int
    let description: String
    let foodType: String
    let image: String
}
