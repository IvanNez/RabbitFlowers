//
//  GodsCollectionViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 30.04.2024.
//

import UIKit
import Kingfisher



// ДЗ
// Добавьте сортировку в товарах 
// Добавьте иконку в таб
// Добавить на первый экран - варианты для связи (UIAlertController)
// 
//

class GoodsCollectionViewController: UICollectionViewController {
    
    var currentID: String?
    var categoryname: String?
    let goodsServices = GoodsServices()
    
    lazy var refreshControl: UIRefreshControl = {
        let rfc = UIRefreshControl()
        rfc.tintColor = allColorsPattern.darkGrayColor
        rfc.addTarget(self, action: #selector(reloaData), for: .valueChanged)
        return rfc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
    }
    
    
    private func setupUI() {
        collectionView.refreshControl = refreshControl
        reloaData()
        title = categoryname
    }
    
    private func setNavBar() {
        let priceLow = UIAction(title: "Сначала дешёвые товары") { _ in
            self.goodsServices.product = self.goodsServices.product.sorted(by:{Int($0.price) ?? 0 <= Int($1.price) ?? 0})
            self.collectionView.reloadData()
        }
        
        let priceExpansice = UIAction(title: "Сначала дорогие товары") { _ in
            self.goodsServices.product = self.goodsServices.product.sorted(by: {Int($0.price) ?? 0 >= Int($1.price) ?? 0})
            self.collectionView.reloadData()
        }
        
        let buttonForMenu = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), primaryAction: nil, menu: UIMenu(title: "Сортировка", children: [priceLow, priceExpansice]))
        buttonForMenu.tintColor = .black
        navigationItem.rightBarButtonItem = buttonForMenu
    }
    
    
    
    @objc func reloaData() {
        guard let currentID else { return }
        
        goodsServices.downloadAllGoodsFromCategory(categoryID: currentID) { [self] result in
            if result {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } else {
                self.refreshControl.endRefreshing()
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsServices.product.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goods", for: indexPath) as! GoodsCollectionViewCell
        let provaider = goodsServices.product[indexPath.row]
        cell.priceTitle.text = "₸\(provaider.price)"
        cell.productImage.kf.setImage(with: URL(string: "\(goodsServices.baseUrl)\(provaider.picture ?? "")"))
        cell.productTitle.text = provaider.name
        return cell
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Goods", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        nextVC.item = goodsServices.product[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension GoodsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemWidth = (view.bounds.width / 2) - 15
        return CGSize(width: itemWidth, height: itemWidth + 80)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

