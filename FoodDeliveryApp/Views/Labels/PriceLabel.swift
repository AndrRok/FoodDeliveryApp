//
//  PriceLabel.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class PriceLabel: UILabel {
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
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure(){
        textColor                                   = .label
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        backgroundColor                             = .systemGray4
        layer.masksToBounds                         = true
        numberOfLines                               = 1
        adjustsFontSizeToFitWidth                   = true
        
    }
    
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                super.drawText(in: rect.inset(by: insets))
    }
}
