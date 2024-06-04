//
//  MainCollectionViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 22.04.2024.
//

import UIKit
import Kingfisher


class MainCollectionViewController: UICollectionViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let rfc = UIRefreshControl()
        rfc.tintColor = allColorsPattern.darkGrayColor
        
        rfc.addTarget(self, action: #selector(refreshDataSet), for: .valueChanged)
        
        return rfc
    }()
    
    let mainClass = MainClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
        settingNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Alerts.shared.alertDialog(presenter: self, title: "Collection", description: "CollectionViewController")
    }
    
    private func setup() {
        collectionView.refreshControl = refreshControl
        tabBarController?.navigationItem.title = "Rabbit Flowers"
        refreshDataSet()
    }
    
    private func settingNavBar() {
        let whastAppAction = UIAction(title: "Написать в Whatsapp") { _ in
            sentToWhatsapp(to: "+77057761728")
        }
        
        let callInShop = UIAction(title: "Позвонить в магазин") { _ in
            callButton(to: "87057761728")
        }
        
        let buttonForMenu = UIBarButtonItem(image: UIImage(systemName: "phone.fill"), primaryAction: nil, menu: UIMenu(title: "Сортировка", children: [whastAppAction, callInShop]))
        buttonForMenu.tintColor = .black
        tabBarController?.navigationItem.rightBarButtonItem = buttonForMenu
    }
    
    
    @objc func refreshDataSet() {
        mainClass.downloadJsonForCategories { [self]  result, error in
            if result {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
//                    print(self.mainClass.allCategories)
                }
            } else {
                Alerts.shared.alertDialog(presenter: self, title: error)
                refreshControl.endRefreshing()
            }
        }
        mainClass.downloadBanner { [self] result in
            if result {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
//                    print(self.mainClass.banners)
                }
            }
        }
    }
        
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        switch section {
        case 0:
            return 1
        case 1:
            return mainClass.allCategories.count
        default:
            return 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let banner = collectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as! BannerCollectionViewCell
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        // Configure the cell
        if indexPath.section == 0 {
            
            if let first = mainClass.banners.first {
                if let urlObj = URL(string: "\(mainClass.baseUrl)\(first.picture ?? "")") {
                    banner.bannerImage.kf.setImage(with: urlObj)
                }
            }
            
            return banner
        }
        
        let provaider = mainClass.allCategories[indexPath.row]
        if let imgURL = URL(string: "\(mainClass.baseUrl)\(provaider.picture ?? "")") {
            categoryCell.categoryImage.kf.setImage(with: imgURL)
        }
        categoryCell.categoryTitle.text = provaider.name
        
        return categoryCell
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let sb = UIStoryboard(name: "Browser", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "BrowserViewController")
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 1 {
            let sb = UIStoryboard(name: "Goods", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "GoodsCollectionViewController") as? GoodsCollectionViewController {
                let provaider = mainClass.allCategories[indexPath.row]
                vc.currentID = provaider.id
                vc.categoryname = provaider.name
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.4) {
                cell.alpha = 0.5

            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.4) {
                cell.alpha = 1.0
            }
        }
    }
 
}


// MARK: -- UICollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: view.bounds.width - 20, height: 130)
        }
        let itemWidth = (view.bounds.width / 2) - 15
        return CGSize(width: itemWidth, height: itemWidth + 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}



