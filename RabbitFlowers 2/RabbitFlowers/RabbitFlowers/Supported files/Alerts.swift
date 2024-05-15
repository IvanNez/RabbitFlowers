//
//  Alerts.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 23.04.2024.
//

import Foundation
import UIKit

class Alerts {
    
    static let shared = Alerts()
    
    func alertDialog(presenter: AnyObject, title: String, description: String = "") {
        
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.view.tintColor = allColorsPattern.baseColor
        alert.addAction(cancel)
        
        if let vc = presenter as? UIViewController {
            vc.present(alert, animated: true)
        } else if let tvc = presenter as? UITableViewController {
            tvc.present(alert, animated: true)
        } else if let cvc = presenter as? UICollectionViewController {
            cvc.present(cvc, animated: true)
        }
        
        
    }
    
}
