//
//  DeliveryListTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 16.05.2024.
//

import UIKit

class DeliveryListTableViewController: UITableViewController {
    
    var listDelivery: [Delivery]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        loadListDelivery()
    }
    
    // через модель
    func loadListDelivery() {
        if let data = UserDefaults.standard.data(forKey: "Delivery") {
            do {
                listDelivery = try JSONDecoder().decode([Delivery].self, from: data)
            } catch {
                print("Не удалось декодировать массив доставок")
            }
        }
        
        // delete delivery if time is over
        if listDelivery != nil {
            listDelivery!.removeAll(where: { delivery in
                let df = DateFormatter()
                
                df.dateFormat = "dd:MM:yy-HH:mm"
                let timeDelivery = df.date(from: delivery.date)
                if timeDelivery! <= Date() {
                    return true
                }
                return false
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDelivery?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DeliveryTableViewCell {
//            if let currentDelivery = listDelivery?[indexPath.row] {
//                cell.addressLBL.text = "Адресс доставки: \(currentDelivery.address)"
//                cell.nameLBL.text = "\(currentDelivery.name)"
//                cell.dateLBL.text = "Дата: \(currentDelivery.date)"
//                cell.numberOfOrderLBL.text = "#\(currentDelivery.orderID)"
//            }
            
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deliveryStatus()
    }
 
    
    func deliveryStatus() {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        if let goToVc = sb.instantiateViewController(withIdentifier: "DeliveryStatusTableViewController") as? DeliveryStatusTableViewController {
            goToVc.count = "hello"
            navigationController?.pushViewController(goToVc, animated: true)
        }
    }
}
