//
//  SectionHeader.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    public static let reuseID = "sectionHeader"
    
    //for 1... sections
    public let label = NameLabel(textAlignment: .left, fontSize: 36)
    
    //only for 0 section
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSalesLayout(in: self))

    private var wholeFoodArray: [Food] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configureForOtherSecions(){
        backgroundColor = .systemBackground
        collectionView.removeFromSuperview()
        configureLabel()
    }
    
    
    public func configureForZeroSection(){
        label.removeFromSuperview()
        configureCollectionView()
        reloadCollectionView()
    }

    
    
    private func configureLabel(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    
    private func configureCollectionView(){
        addSubview(collectionView)
        collectionView.delegate                                     = self
        collectionView.dataSource                                   = self
        collectionView.showsHorizontalScrollIndicator               = false
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.register(SaleCell.self, forCellWithReuseIdentifier: SaleCell.reuseID)
        
        
        
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -frame.height/6),
            collectionView.widthAnchor.constraint(equalToConstant: frame.width)
            
        ])
    }
    
    
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}



extension SectionHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wholeFoodArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCell.reuseID, for: indexPath) as! SaleCell
        let foodItem = wholeFoodArray[indexPath.row]
        
        cell.set(foodItem: foodItem)
        
        return cell
        
    }
    
}

extension SectionHeader: SendSalesDataToHeaderProtocol{
    func sendDataToHeader(foodArray: [Food]) {
        wholeFoodArray = foodArray
        reloadCollectionView()
    }
    
    
}
