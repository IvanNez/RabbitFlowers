//
//  ProfileViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 19.05.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameTF: OneLineTextField!
    @IBOutlet weak var addressTF: OneLineTextField!
    @IBOutlet weak var phoneNumberTF: OneLineTextField!
    @IBOutlet weak var valueTypeSC: UISegmentedControl!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        phoneNumberTF.delegate = self
        valueTypeSC.backgroundColor = allColorsPattern.baseColor
        date.minimumDate = Date()
        doneButton.tintColor = allColorsPattern.baseColor
        doneButton.layer.masksToBounds = true
        doneButton.layer.cornerRadius = 10
        loadData()
    }
    
    func loadData() {
        if let myData = UserDefaults.standard.value(forKey:"OrderData") as? Data {
            let data = try? PropertyListDecoder().decode(OrderData.self, from: myData)
            nameTF.text = data?.name
            addressTF.text = data?.address
            phoneNumberTF.text = data?.phone
            let df = DateFormatter()
            df.dateFormat = "dd:MM:yy-HH:mm"
            date.date = df.date(from: data!.date) ?? Date()
        }
    }
    
    
    // MARK: -- OBJC
    @IBAction func doneButtonTap() {
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
        
        title = "Сохранено!"
        
        let df = DateFormatter()
        
        df.dateFormat = "dd:MM:yy-HH:mm"
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(OrderData(name: name, address: address, phone: number, payment: valueTypeSC.selectedSegmentIndex == 0 ? true: false, date: df.string(from: date.date))), forKey: "OrderData")
    }
}

// MARK: -- UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
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
