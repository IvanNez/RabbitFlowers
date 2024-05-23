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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageIcon.tintColor = allColorsPattern.baseColor
        nameProduct.textColor = allColorsPattern.blackColor
        idDelivery.textColor = allColorsPattern.blackColor
        dataDelivery.textColor = allColorsPattern.darkGrayColor
        adressDelivery.textColor = allColorsPattern.darkGrayColor
    }
    
    
}
