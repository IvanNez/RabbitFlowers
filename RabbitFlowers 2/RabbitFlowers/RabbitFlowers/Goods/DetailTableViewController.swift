//
//  DetailTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 06.05.2024.
//

import UIKit
import Kingfisher

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var heightImage: NSLayoutConstraint!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    
    var item: AllGoodsStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        if let item {
            
            let stringURL = "https://rabbitflowers.kz\(item.picture ?? "")"
            
            guard let url = URL(string: stringURL) else { return }
            mainImage.kf.setImage(with: url)
            titleLBL.text = item.name
            priceLBL.text = "₸\(item.price)"
            descriptionLBL.text = item.description
        } else {
            buyButton.isHidden = true
        }
        
    }
    
    func setup() {
        title = "О товаре"
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    @IBAction func buyButtonTUI(_ sender: UIButton) {
        sender.backgroundColor = allColorsPattern.shadowColor
        let sb = UIStoryboard( name: "Goods", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "OrderTableViewController") as? OrderTableViewController {
            guard let item else { return }
            vc.productId = item.id
            vc.productPrice = item.price
            vc.productTitle = item.name
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func buyButtonTUO(_ sender: UIButton) {
        sender.backgroundColor = allColorsPattern.baseColor
        print(#function)
    }
}
