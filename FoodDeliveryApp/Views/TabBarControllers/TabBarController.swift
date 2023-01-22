//
//  TabBarController.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().backgroundColor = Colors.mainBackGroundColor
       UITabBar.appearance().tintColor       = .systemPink
        UITabBar.appearance().barTintColor = Colors.mainBackGroundColor
        
        viewControllers                       = [createMenuNC(), createContactsNC(), createProfileNC(), createCartNC()]
    }
    
    
    
    
    private func createMenuNC() -> UINavigationController{
        let menuVC          = MenuVC()
        menuVC.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(named: "pizzaIcon"), tag: 0)
        
        return UINavigationController(rootViewController: menuVC)
    }
    
    
    private func createContactsNC() -> UINavigationController{
        let contactsVC   = ContactsVC()
        contactsVC.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(named: "markerIcon"), tag: 1)
        return UINavigationController(rootViewController: contactsVC)
    }
    
    private func createProfileNC() -> UINavigationController{
        let profileVC   = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 2)
        return UINavigationController(rootViewController: profileVC)
    }
    
    
    private func createCartNC() -> UINavigationController{
        let cartVC   = CartVC()
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart.fill"), tag: 3)
        return UINavigationController(rootViewController: cartVC)
    }
}

