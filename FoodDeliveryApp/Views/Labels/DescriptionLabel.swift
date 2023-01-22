//
//  DescriptionLabel.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class DescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure(){
        textColor                                   = .gray
        adjustsFontSizeToFitWidth                   = true
        //minimumScaleFactor                        = 0.90
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
        numberOfLines                               = 0
        adjustsFontSizeToFitWidth                   = false
        
    }
}
