//
//  OrderTableViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 07.05.2024.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var changeType: UISegmentedControl!
    @IBOutlet weak var aboutOrder: UITextField!
    @IBOutlet weak var dateAndTime: UIDatePicker!
    @IBOutlet weak var buyButton: ButtonMain!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    var productId: String?
    var productTitle: String?
    var productPrice: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Оформление заказа"
        phoneNumberTF.delegate = self
        
        dateAndTime.date = Date()
        dateAndTime.minimumDate = Date()
        
        guard let productId, let  productTitle, let productPrice else {
            buyButton.isHidden = true
            return
        }
        
        productTitleLabel.text = productTitle
        productPriceLabel.text = "$\(productPrice)"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTF.becomeFirstResponder()
        
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        preOrderValid()
    }
    
    
    private func preOrderValid() {
        if currentReachabilityStatus == .notReachable {
            Alerts.shared.alertDialog(presenter: self, title: "Нет интернета")
            return
        }
        
        guard let name = nameTF.text else {
            return
        }
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            Alerts.shared.alertDialog(presenter: self, title: "Заполните имя")
            return
        }
        
        guard let address = addressTF.text else {
            return
        }
        
        if address.trimmingCharacters(in: .whitespaces).isEmpty {
            Alerts.shared.alertDialog(presenter: self, title: "Заполните адресс")
            return
        }
        
        guard let number = phoneNumberTF.text else {
            return
        }
        
        if number.count != 17 {
            Alerts.shared.alertDialog(presenter: self, title: "Заполните номер")
            return
        }
        
        title = "Complited!"
        
        
        
        sendDataToServer()
    }
    
    
    private func sendDataToServer() {
        
        let sendDataURL = "https://rabbitflowers.kz/json/order.php"
        
        guard let productId, let  productTitle, let productPrice else {
            return
        }
        
        guard let phone = phoneNumberTF.text, let adress = addressTF.text, let note = aboutOrder.text else {
            return
        }
        
        let df = DateFormatter()
        
        df.dateFormat = "dd:MM:yy-HH:mm"
        
        
        let paymentType = changeType.selectedSegmentIndex == 0 ? true: false
        
        let dataToServer = DataSend(id: productId, name: productTitle, phone: phone, adress: adress, note: note, sum: productPrice, date: df.string(from: dateAndTime.date), paymentType: paymentType)
        
        
        // MARK: -- Request -------
        
        guard let url = URL(string: sendDataURL) else {
            Alerts.shared.alertDialog(presenter: self, title: "Ошибка", description: "Неправильный запрос")
            return }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let encode = JSONEncoder()
        do {
            let jsonData = try encode.encode(dataToServer)
            request.httpBody = jsonData
            print("JSON DATA:", String(data: request.httpBody!, encoding: .utf8) ?? "No data!!!!")
        } catch {
            Alerts.shared.alertDialog(presenter: self, title: "Ошибка при отправке данных", description: error.localizedDescription)
        }
        
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
            
            let allStatuses = [200, 201]
            
            guard allStatuses.contains(response.statusCode) else {
                return
            }
            
            do {
                
//                print("String Data from server", String(data: data, encoding: .utf8) ?? "")
                
                
                let jsonResponse = try
                JSONDecoder().decode(DataResponse.self, from: data)
                if jsonResponse.result.lowercased() == "success" {
                    
                    //print("JSON RESULT", jsonResponse)
                    
                    DispatchQueue.main.async {
                        guard let productTitle = self.productTitle else { return }
                        let delivery = Delivery(name: productTitle, orderID: jsonResponse.orderid, date: df.string(from: self.dateAndTime.date), address: adress)
                        
                       
                        var deliveryArray = [Delivery]()
                       
                        if let myData = UserDefaults.standard.value(forKey:"Delivery") as? Data {
                            
                            let data = try? PropertyListDecoder().decode([Delivery].self, from: myData)
                            deliveryArray = data ?? []
                        }
                        
                        deliveryArray.append(delivery)
                        
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(deliveryArray), forKey: "Delivery")
                        
                        
                         Alerts.shared.alertDialog(presenter: self, title: "Ваш заказ успешно оформлен, ждите звонка нашего манеджера", description: "Код заказа \(jsonResponse.orderid)")
                    }
                }
            } catch {
                print("Заказ не был оформлен")
            }
            
            
        }
        
        responseTask.resume()
    }
}




extension OrderTableViewController: UITextFieldDelegate {
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X (XXX) XXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = phoneNumberTF.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        return false
    }
}

