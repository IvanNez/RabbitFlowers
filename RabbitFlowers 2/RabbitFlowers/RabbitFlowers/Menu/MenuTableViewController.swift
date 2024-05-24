//
//  MenuTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 22.04.2024.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let menuClass = MenuClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavBar()
    }

    // MARK: - Table view data source
    
    private func setNavBar() {
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        menuClass.category.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        menuClass.category[section].items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var defaultContent = cell.defaultContentConfiguration()
        
        let provaider = menuClass.category[indexPath.section].items[indexPath.row]
        defaultContent.text = provaider.title
        defaultContent.secondaryText = provaider.description
        defaultContent.image = UIImage(systemName: provaider.image ?? "")
        defaultContent.imageProperties.tintColor = allColorsPattern.baseColor
        defaultContent.textProperties.font = .boldSystemFont(ofSize: 18)
        defaultContent.secondaryTextProperties.color = allColorsPattern.darkGrayColor
        defaultContent.secondaryTextProperties.font = .systemFont(ofSize: 15)
        
        
        cell.contentConfiguration = defaultContent

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        menuClass.category[section].titleSection
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let provaider = menuClass.category[indexPath.section].items[indexPath.row]
        
        switch provaider.id {
        case 1:
            let showVC = storyboard.instantiateViewController(identifier: "ProfileViewController")
            navigationController?.pushViewController(showVC, animated: true)
        case 2:
            let showVC = storyboard.instantiateViewController(identifier: "DeliveryListTableViewController")
            navigationController?.pushViewController(showVC, animated: true)
        case 3:
            let showVC = storyboard.instantiateViewController(withIdentifier: "AboutAppViewController")
            navigationController?.pushViewController(showVC, animated: true)
        case 4:
            let showVC = storyboard.instantiateViewController(withIdentifier: "MapShopViewController")
            navigationController?.pushViewController(showVC, animated: true)
        case 5:
            callButton(to: "87057761728")
        default:
            break
        }
    }
}
