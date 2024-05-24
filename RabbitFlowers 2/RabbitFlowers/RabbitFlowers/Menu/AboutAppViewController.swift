//
//  AboutAppViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 24.05.2024.
//

import UIKit
import StoreKit

class AboutAppViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func writeSupportButton(_ sender: Any) {
        sentToMail(to: "headshot.kill96@icloud.com")
    }
    
    
    @IBAction func rateProfile(_ sender: Any) {
        if let windowScene = view.window?.windowScene {
                    SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}

