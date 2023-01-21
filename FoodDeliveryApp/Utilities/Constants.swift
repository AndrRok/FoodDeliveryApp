//
//  Constants.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

enum Colors{
    static let mainBackGroundColor          = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
    static let additionalColor              = UIColor(red: 0, green: 0.9569, blue: 0.8627, alpha: 1.0)
    static let categoryCellColor            = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
    static let unselectedColor              = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
    static let selectedColor                = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
    
}

enum Values{
    static let  salesHeaderHeight: CGFloat          = 230
    static let  categoriesqHeaderHeight: CGFloat    = 60
    static let  padding: CGFloat                    = 20
}

enum Images {
    static let placeholder = UIImage(named: "placeholderimage")
}


enum ErrorMessages: String, Error {
    
    case invalidRequest     = "This request created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}


