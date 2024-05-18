//
//  DeliveryTableViewCell.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 16.05.2024.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var idDelivery: UILabel!
    @IBOutlet weak var dataDelivery: UILabel!
    @IBOutlet weak var adressDelivery: UILabel!
    
    override  func awakeFromNib() {
        imageIcon.tintColor = allColorsPattern.baseColor
    }
    
    
}
