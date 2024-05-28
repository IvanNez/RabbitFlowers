//
//  OrderClass.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 07.05.2024.
//

import Foundation

class OrderClass {
    
    var orderData: OrderData?
    
    func loadDataOrder() {
        if let myData = UserDefaults.standard.value(forKey:"OrderData") as? Data {
            let data = try? PropertyListDecoder().decode(OrderData.self, from: myData)
            orderData = data
        }
    }
}
