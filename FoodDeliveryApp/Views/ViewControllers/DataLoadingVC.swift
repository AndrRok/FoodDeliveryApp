//
//  DataLoadingVC.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class DataLoadingVC: UIViewController {
    
    lazy var containerView = UIView(frame: .zero)
    
    
    public func showLoadingView() {
        view.addSubview(containerView)
        
        containerView.backgroundColor   = Colors.mainBackGroundColor
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    public func dismissLoadingView() {
        DispatchQueue.main.async{
            self.containerView.removeFromSuperview()
        }
    }

}
 

