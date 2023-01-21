//
//  FoodItemCell.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class FoodItemCell: UICollectionViewCell {
    
    public static let reuseID = "FoodItemCell"
    
    var cellId      = 0
    
    var foodNameLabel           = NameLabel(textAlignment: .left, fontSize: 18)
    var foodDescriptionLabel    = DescriptionLabel(textAlignment: .left, fontSize: 16)
    var foodPriceLabel          = PriceLabel(textAlignment: .left, fontSize: 30)
    let foodImageView           = ImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(foodItem: Food){
        foodNameLabel.text = foodItem.name
        foodDescriptionLabel.text = foodItem.description
        foodPriceLabel.text = String(foodItem.price) + " руб"
        foodImageView.downloadImage(fromURL: foodItem.image)
    }
    
    
   private func configure(){
    
       addSubviews(foodImageView, foodNameLabel, foodDescriptionLabel, foodPriceLabel)
       foodNameLabel.translatesAutoresizingMaskIntoConstraints        = false
       foodDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
       foodPriceLabel.translatesAutoresizingMaskIntoConstraints       = false
       foodImageView.translatesAutoresizingMaskIntoConstraints        = false
       
       let padding: CGFloat = 10
       
       
       NSLayoutConstraint.activate([
        
        foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
        foodImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        foodImageView.heightAnchor.constraint(equalToConstant: 150),
        foodImageView.widthAnchor.constraint(equalTo: foodImageView.heightAnchor),
        
        foodNameLabel.topAnchor.constraint(equalTo: foodImageView.topAnchor),
        foodNameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: padding),
        foodNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        
        
        foodPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        foodPriceLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: padding),
        foodPriceLabel.heightAnchor.constraint(equalToConstant: 40),
        
        foodDescriptionLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: padding),
        foodDescriptionLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: padding),
        foodDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        foodDescriptionLabel.bottomAnchor.constraint(equalTo: foodPriceLabel.topAnchor, constant: -padding),
        
        

       ])
    }
    
    
}
