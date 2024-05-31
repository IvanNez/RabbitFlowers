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
        let addOrder = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOrderButton))
        navigationItem.rightBarButtonItem = addOrder
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryModel.listDelivery.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryTableViewCell
            let delivery = deliveryModel.listDelivery[indexPath.row]
            cell.adressDelivery.text = delivery.address
            cell.dataDelivery.text = delivery.date
            cell.idDelivery.text = "#\(delivery.orderID)"
            cell.nameProduct.text = delivery.name
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliveryId = deliveryModel.listDelivery[indexPath.row].orderID
        deliveryStatus(id: deliveryId)
    }
    
    
    func deliveryStatus(id: Int) {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        if let goToVc = sb.instantiateViewController(withIdentifier: "DeliveryStatusTableViewController") as? DeliveryStatusTableViewController {
            goToVc.count = "hello"
            present(goToVc, animated: true)
        }
    }
    
    @objc func addOrderButton() {
        let alert = UIAlertController(title: "Добавление заказа", message: "Напишите свой номер заказа в поле ввода", preferredStyle: .alert)
        alert.addTextField() { tf in
            tf.placeholder = "Введите номер заказа"
        }
        let addOrder = UIAlertAction(title: "Готово", style: .destructive) { _ in
            let tf = Int(alert.textFields?.first?.text ?? "0")
            self.deliveryStatus(id: tf ?? 0)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(addOrder)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
}
