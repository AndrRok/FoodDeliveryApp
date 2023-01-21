//
//  CustomButtom.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class CustomButtom: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, textColor: UIColor){
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.tintColor = textColor
    }
    private func configure(){
        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func set(backgroundColor: UIColor, title: String){
        self.backgroundColor    = backgroundColor
        setTitle(title, for: .normal)
    }
}

