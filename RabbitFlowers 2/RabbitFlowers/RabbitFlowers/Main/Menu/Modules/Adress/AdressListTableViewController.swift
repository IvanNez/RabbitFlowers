//
//  AdressListTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 28.05.2024.
//

import UIKit
import MapKit

class AdressListTableViewController: UITableViewController {
    
    let addressListModel = AdressListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let showMapButton = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .done, target: self, action: #selector(showMapButtonTap))
        showMapButton.tintColor = allColorsPattern.blackColor
        navigationItem.rightBarButtonItem = showMapButton
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
        defaultContent.secondaryText = "87057761728"
        defaultContent.image =  UIImage(systemName: ("mappin.circle.fill"))
        defaultContent.imageProperties.tintColor = allColorsPattern.baseColor
        
        cell.contentConfiguration = defaultContent
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let provaider = addressListModel.adress[indexPath.row]
        showMap(span: addressListModel.span, center: provaider.loc)
    }
    
    func showMap(span: MKCoordinateSpan?, center: CLLocationCoordinate2D?) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let goToVC = storyboard.instantiateViewController(withIdentifier: "MapShopViewController") as! MapShopViewController
        goToVC.center = center
        goToVC.span = span
        goToVC.pins = addressListModel.adress
        navigationController?.pushViewController(goToVC, animated: true)
    }
    
    //MARK: -- OBJC
    @objc func showMapButtonTap() {
        showMap(span: MKCoordinateSpan(latitudeDelta: 0.250, longitudeDelta: 0.250), center: CLLocationCoordinate2D(latitude: 51.137507, longitude: 71.426535))
    }
    
    
}
