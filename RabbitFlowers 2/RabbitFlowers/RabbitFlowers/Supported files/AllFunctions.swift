//
//  AllFunctions.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 23.04.2024.
//

import Foundation
import UIKit


enum AllApps: String {
    case gmail = "googlegmail:///co?to=headshot.kill96@gmail.com&subject=fromapp&body="
    case mail = "mailto:headshot.kill96@icloud.com"
    case whatApp = "https://api.whatsapp.com/send?phone=870557761728"
}

func convertRGBToHEX(hexStr: String) -> UIColor {
    
    let getHEX = hexStr.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    
    var int = UInt64()
    
    Scanner(string: getHEX).scanHexInt64(&int)
    
    let a, r, g, b: UInt64
    
    switch getHEX.count {
    case 3:
        (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        
    case 6:
        (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        
    case 8:
        (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        
    default:
        (a, r, g, b) = (255, 0, 0, 0)
    }
    
    return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
}


func sentToGmail(to: String) {
    let googleUrlString = "googlegmail:///co?to=\(to)&subject=fromapp&body="

    guard let gmailURL = URL(string: googleUrlString) else {
        return
    }
    if UIApplication.shared.canOpenURL(gmailURL) {
        UIApplication.shared.open(gmailURL)
    }
}
func sentToMail(to: String) {
    let mailString = "mailto:\(to)"

    guard let mailUrl = URL(string: mailString) else {
        return
    }
    if UIApplication.shared.canOpenURL(mailUrl) {
        UIApplication.shared.open(mailUrl)
    }
}

func sentToWhatsapp(to: String) {
    let whatsappString = "https://api.whatsapp.com/send?phone=\(to)"

    guard let whatsappUrl = URL(string: whatsappString) else {
        return
    }
    if UIApplication.shared.canOpenURL(whatsappUrl) {
        UIApplication.shared.open(whatsappUrl)
    }
}
func callButton(to phoneNumber: String) {
    guard let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL)  else {
        return
    }
    UIApplication.shared.open(phoneURL)
}



func findApp(app: AllApps) -> Bool {
        guard let url = URL(string: app.rawValue) else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(url)
    }





