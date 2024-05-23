//
//  DeliveryStatusTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 16.05.2024.
//

import UIKit

class DeliveryStatusTableViewController: UITableViewController {
    
    @IBOutlet weak var statusLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var totalLBL: UILabel!
    @IBOutlet weak var noteLBL: UILabel!
    @IBOutlet weak var adressLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    
    
    var count: String?
    var deliveryResponseStruct = DeliveryStatusResponse(status: "Ожидайте звонка нашего менеджера", date: "Нет данных", total: "Проверяется", note: "Данные на проверка", destination: "Проверяется", deltime: "Уточнение")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(count ?? "")
        loadStatus()
        
//        
//        myArray.append(.first(DeliveryStatusResponse(status: <#T##String#>, date: <#T##String#>, total: <#T##String#>, note: <#T##String#>, destination: <#T##String#>, deltime: <#T##String#>)))
        
    }
    
    func showData(data: DeliveryStatusResponse) {
        statusLBL.text = "\(data.status)"
        dateLBL.text = "\(data.date)"
        totalLBL.text = "\(data.total)"
        noteLBL.text = data.note.count == 0 ? "Нет данных": data.note
        adressLBL.text = "\(data.destination)"
        timeLBL.text = "\(data.deltime)"
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currentReachabilityStatus == .notReachable {
            return 0
        }
        
        return 70
        
    }
    
    
    
    
    func loadStatus() {
        
        guard currentReachabilityStatus != .notReachable else {
            return
        }
        
        
        let urlString = "https://rabbitflowers.kz/json/delivery.php"
        
        guard let orderID = count else {
            return
        }
        
        var login =  DeliveryStatusRequest(login: "\(orderID)", password: "1wflx36")
        
        
        
        
        guard let url = URL(string: urlString) else {
            Alerts.shared.alertDialog(presenter: self, title: "Ошибка", description: "Неправильный запрос")
            return }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let encode = JSONEncoder()
        do {
            let jsonData = try encode.encode(login)
            request.httpBody = jsonData
            print("JSON DATA:", String(data: request.httpBody!, encoding: .utf8) ?? "No data!!!!")
        } catch {
            Alerts.shared.alertDialog(presenter: self, title: "Ошибка при отправке данных", description: error.localizedDescription)
        }
        
        // MARK: -- Response
        
        let responseTask = URLSession.shared.dataTask(with: request as URLRequest) {
            dataTask, responseTask, errorTask in
            
            guard errorTask == nil else {
                DispatchQueue.main.async {
                    Alerts.shared.alertDialog(presenter: self, title: "Ошибка")
                }
                return
            }
            
            guard let data = dataTask else { return }
            
            guard let response = responseTask as? HTTPURLResponse else { return }
            
            do {
                
                self.deliveryResponseStruct = try JSONDecoder().decode(DeliveryStatusResponse.self, from: data)
                DispatchQueue.main.async {
                    print(self.deliveryResponseStruct)
                    self.showData(data: self.deliveryResponseStruct)
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
            
            responseTask.resume()
    }
}
