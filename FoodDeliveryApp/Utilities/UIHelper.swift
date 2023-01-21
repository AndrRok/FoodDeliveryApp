//
//  UIHelper.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit


enum UIHelper{
    
    
    //MARK: - Compositional layout for categories
    
    static func createCategoriesLayout(in view: UIView) -> UICollectionViewCompositionalLayout{
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 2)
        // Group
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), repeatingSubitem: item, count: 1)
        
        // Sections
        
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .paging
        
        
        
        // Return
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        
        return layout
        
        
        
    }
    
    
    
    
    
    
    //MARK: - Compositional layout for sales
    static func createSalesLayout(in view: UIView) -> UICollectionViewCompositionalLayout{
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), repeatingSubitem: item, count: 1)
        
        // Sections
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        // Return
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        //}
    }
    
    
    
    
    
    //MARK: - Compositional layout for items
    static func createLayout(in view: UIView) -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout{ (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            // Item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            // Group
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240)), repeatingSubitem: item, count: 1)
            
            // Sections
            
            let section = NSCollectionLayoutSection(group: group)
            let headerKind = UICollectionView.elementKindSectionHeader
            var headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
            
            switch sectionNumber{
            case 0:
                headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
            default:
                break
            }
            
            
            
            
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: headerKind, alignment: .top)
            // for sticky header
            headerElement.pinToVisibleBounds = true
            
            section.boundarySupplementaryItems = [headerElement]
            // Return
            return section
        }
    }
    
}

