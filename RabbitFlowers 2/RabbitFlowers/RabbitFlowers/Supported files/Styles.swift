//
//  Styles.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 23.04.2024.
//

import Foundation
import UIKit


let allColorsPattern = (baseColor: convertRGBToHEX(hexStr: "cd3367"), shadowColor: convertRGBToHEX(hexStr: "ff749a"), blackColor: UIColor.black, darkGrayColor: UIColor.darkGray, whiteColor: UIColor.white)

class BannerViewStyle: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.baseColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
        
        self.backgroundColor = allColorsPattern.shadowColor
    }
}

class CategoryViewStyle: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        
    }
}

class ProductViewStyle: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
    }
}

class DetailViewStyle: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.baseColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
        
        self.backgroundColor = allColorsPattern.shadowColor
    }
}

class OrderViewStyle: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowColor = allColorsPattern.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        
    }
}

class ButtonMain: UIButton {
    override  func awakeFromNib() {
        self.backgroundColor = allColorsPattern.baseColor
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
        self.tintColor = .white
    }
}

class ButtonWriteSupport: UIButton {
    override  func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.baseColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
        self.tintColor = .white
    }
}

class ButtonRateApp: UIButton {
    override  func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
        self.tintColor = .white
    }
}




class DeliveryCardStyle: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
        self.layer.shadowColor = allColorsPattern.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
    }
}

class OneLineTextField: UITextField {
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        
        var bottonView = UIView()
        bottonView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottonView.backgroundColor = .darkGray
        bottonView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottonView)
        
        NSLayoutConstraint.activate([
            bottonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottonView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

// cd3367
// ff749a
