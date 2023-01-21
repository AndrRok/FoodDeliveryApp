//
//  ImageView.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class ImageView: UIImageView {
    
    private let placeholderImage    = Images.placeholder
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius                          = 10
        clipsToBounds                               = true
        image                                       = placeholderImage
        translatesAutoresizingMaskIntoConstraints   = true
        contentMode                                 = .scaleAspectFill
    }
    
    
    public func downloadImage(fromURL url: String){
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {self.image = image}
        }
    }
    
}
