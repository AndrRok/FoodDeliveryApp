//
//  MenuVC.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

protocol ScrollCategoriesMenuDelegate{
    func scrollCategoriesMenuTo(rowOfHeader: Int)
    
}

protocol SendSalesDataToHeaderProtocol{
    func sendDataToHeader(foodArray: [Food])
}


class MenuVC: DataLoadingVC {
    
    private lazy var collectionView         = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLayout(in: view))
    private lazy var headerViewCategories   = CategoriesHeaderView(frame: .zero)
    
    
    private var wholeFoodArray  : [Food] = []
    private var pizzaArray      : [Food] = []
    private var burgersArray    : [Food] = []
    private var dessertArray    : [Food] = []
    private var drinkArray      : [Food] = []
    private var comboArray      : [Food] = []
    private var delegateThree: ScrollCategoriesMenuDelegate?
    private var sendDataDelegate: SendSalesDataToHeaderProtocol?
    
    private var isSelectingCategory = true
    private var neededIndexPath = IndexPath(row: 0, section: 0)
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        title = "Pizza"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 27)!,
         NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.backgroundColor = Colors.mainBackGroundColor
        navigationController?.navigationBar.barTintColor    = Colors.mainBackGroundColor
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainBackGroundColor
        
        configureCollectionView()
        configureStickyHeader(space: Values.categoriesqHeaderHeight)
        getFood()
        headerViewCategories.delegateTwo = self
        self.delegateThree = headerViewCategories
    }
    
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = Colors.mainBackGroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.showsVerticalScrollIndicator               = false
        collectionView.register(FoodItemCell.self, forCellWithReuseIdentifier: FoodItemCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)//adds space in the end of tableView
        collectionView.contentInset = insets
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    
    private func configureStickyHeader(space: CGFloat){
        headerViewCategories.removeFromSuperview()
        view.addSubview(headerViewCategories)
        headerViewCategories.translatesAutoresizingMaskIntoConstraints = false
        headerViewCategories.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            headerViewCategories.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: space),
            headerViewCategories.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerViewCategories.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerViewCategories.widthAnchor.constraint(equalToConstant: view.frame.width),
            headerViewCategories.heightAnchor.constraint(equalToConstant: Values.categoriesqHeaderHeight)
            
        ])
    }
    
    
    private func getFood(){
        showLoadingView()
        NetworkManager.shared.getFoodList()  { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let resultsFood):
                self.wholeFoodArray = resultsFood
                self.sortArrayByCategory()
                self.reloadCollectionView()
            case .failure(let error):
                self.presentCustomAllertOnMainThred(allertTitle: "Bad Stuff Happend", message: error.rawValue, butonTitle: "Ok")
            }
        }
        
    }
    
    private func sortArrayByCategory(){
        pizzaArray      = wholeFoodArray.filter {$0.foodType.contains("pizza")   }
        burgersArray    = wholeFoodArray.filter {$0.foodType.contains("burger")  }
        dessertArray    = wholeFoodArray.filter {$0.foodType.contains("dessert") }
        drinkArray      = wholeFoodArray.filter {$0.foodType.contains("drink")   }
        comboArray      = wholeFoodArray.filter {$0.foodType.contains("combo")   }
    }
    
    
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.sendDataDelegate?.sendDataToHeader(foodArray: self.wholeFoodArray)
        }
    }
    
}


//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section) {
        case 0://Empty
            return 0
            
        case 1://Pizza
            return pizzaArray.count
            
        case 2://Burgers
            return burgersArray.count
            
        case 3://Dessert
            return dessertArray.count
            
        case 4://Drink
            return drinkArray.count
            
        case 5://Combo
            return comboArray.count
            
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodItemCell.reuseID, for: indexPath) as! FoodItemCell
        
        switch (indexPath.section) {
            
        case 1://Pizza
            let pizza = pizzaArray[indexPath.row]
            cell.set(foodItem: pizza)
            
        case 2://Burgers
            let burger = burgersArray[indexPath.row]
            cell.set(foodItem: burger)
            
        case 3://Dessert
            let dessert = dessertArray[indexPath.row]
            cell.set(foodItem: dessert)
            
        case 4://Drink
            let drink = drinkArray[indexPath.row]
            cell.set(foodItem: drink)
            
        case 5://Combo
            let combo = comboArray[indexPath.row]
            cell.set(foodItem: combo)
            
        default:
            break
        }
        
        return cell
    }
}



extension MenuVC{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
            sendDataDelegate = sectionHeader
            sectionHeader.backgroundColor = Colors.mainBackGroundColor
            
            collectionView.bringSubviewToFront(sectionHeader)
            
            
            switch (indexPath.section) {
            case 0://Empty
                
                sectionHeader.configureForZeroSection()
                
            case 1://Pizza
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Pizza"
                
            case 2://Burgers
                
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Burgers"
                
            case 3://Dessert
                
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Dessert"
                
            case 4://Drink
                
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Drink"
                
            case 5://Combo
                
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Combo"
                
            default:
                
                break
            }
            
            return sectionHeader
            
        } else {
            
            return UICollectionReusableView()
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let fullyVisibleIndexPaths = (collectionView.indexPathsForFullyVisibleItems().first?.section ?? 1) - 1
        let offSetY = scrollView.contentOffset.y//already scrolled data
        
        
        switch offSetY {
        case 0:
            configureStickyHeader(space: Values.salesHeaderHeight + Values.padding)
            
        case 1...Values.salesHeaderHeight:
            configureStickyHeader(space: (Values.salesHeaderHeight + Values.padding - offSetY))
            
        case Values.salesHeaderHeight...:
            configureStickyHeader(space: 0)
            
        default:
            configureStickyHeader(space: (-offSetY + Values.salesHeaderHeight + Values.padding))
            
        }
        
        
        if isSelectingCategory == false{
            self.delegateThree?.scrollCategoriesMenuTo(rowOfHeader: fullyVisibleIndexPaths)
        } else {
            if fullyVisibleIndexPaths == neededIndexPath.row {
                
                isSelectingCategory = false
                neededIndexPath = IndexPath(row: 0, section: 0)
            }
        }
        
    }
    
}



//MARK: - ScrollToRowDetegateFromCollectionViewToTableView
extension MenuVC: ScrollToRowDetegateFromCollectionViewToTableView{
    func sendRowToTableView(_ row: Int, isSelectingCategory: Bool) {
        
        switch row {
        case 0:
            DispatchQueue.main.async {
                self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
        default:
            neededIndexPath = IndexPath(row: 0, section: row + 1)
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: self.neededIndexPath, at: .centeredVertically, animated: true)
            }
        }
        
        self.isSelectingCategory = isSelectingCategory
        
    }
    
}
