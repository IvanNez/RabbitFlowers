//
//  DeliveryModel.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 19.05.2024.
//

import Foundation

class DeliveryListModel {
    
    var listDelivery = [Delivery]()
    
    func loadListDelivery() {
        if let myData = UserDefaults.standard.value(forKey: "Delivery") as? Data {
            do {
                let data = try PropertyListDecoder().decode([Delivery].self, from: myData)
                listDelivery = data
            } catch {
                print("Не удалось декодировать массив доставок")
            }
            
        }
        
        // delete delivery if time is over
        let df = DateFormatter()
        df.dateFormat = "dd:MM:yy-HH:mm"
        
        listDelivery.removeAll(where: { delivery in
            if let timeDelivery = df.date(from: delivery.date) {
                return timeDelivery < Date()
            }
            return false
        })
        
    }
}
