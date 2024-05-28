//
//  AdressListTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 28.05.2024.
//

import UIKit

class AdressListTableViewController: UITableViewController {
    
    let addressListModel = AdressListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressListModel.adress.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var defaultContent = cell.defaultContentConfiguration()
        let provaider = addressListModel.adress[indexPath.row]
        defaultContent.text = provaider.adress
        
        cell.contentConfiguration = defaultContent
        return cell
    }
    
}
