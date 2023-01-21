//
//  CategoriesHeaderView.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit


protocol ScrollToRowDetegateFromCollectionViewToTableView{
    func sendRowToTableView(_ row: Int, isSelectingCategory: Bool)
}


class CategoriesHeaderView: UIView {
    
    public var delegateTwo: ScrollToRowDetegateFromCollectionViewToTableView?
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCategoriesLayout(in: self))
    
    private var isSecelctingCategory = true

    private let categoryArray = ["Pizza", "Burgers", "Dessert", "Drink", "Combo"]
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        configureCollectionView()
    }
    
    
    private func configureCollectionView(){
        addSubview(collectionView)
        collectionView.clipsToBounds = true
        collectionView.delegate                                     = self
        collectionView.dataSource                                   = self
        collectionView.showsHorizontalScrollIndicator               = false
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        
    }
}




//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CategoriesHeaderView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        let number = categoryArray[indexPath.row]
        cell.set(text: number)
        return cell
        
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSecelctingCategory = true
        delegateTwo?.sendRowToTableView(indexPath.row, isSelectingCategory: isSecelctingCategory)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        isSecelctingCategory = false
    }
 
}



//MARK: - ScrollCategoriesMenuDelegate
extension CategoriesHeaderView: ScrollCategoriesMenuDelegate{
    func scrollCategoriesMenuTo(rowOfHeader: Int) {
        DispatchQueue.main.async {
            self.collectionView.selectItem(at: IndexPath(item: rowOfHeader, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        }
        
        
    }
}
