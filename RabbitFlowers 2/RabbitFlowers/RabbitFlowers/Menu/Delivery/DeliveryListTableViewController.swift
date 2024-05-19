//
//  DeliveryListTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 16.05.2024.
//

import UIKit

class DeliveryListTableViewController: UITableViewController {
    
    var deliveryModel = DeliveryListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        deliveryModel.loadListDelivery()
    }
    
    deinit {
        print("deinit")
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryModel.listDelivery.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DeliveryTableViewCell {
            let delivery = deliveryModel.listDelivery[indexPath.row]
            cell.adressDelivery.text = delivery.address
            cell.dataDelivery.text = delivery.date
            cell.idDelivery.text = "#\(delivery.orderID)"
            cell.nameProduct.text = delivery.name
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
