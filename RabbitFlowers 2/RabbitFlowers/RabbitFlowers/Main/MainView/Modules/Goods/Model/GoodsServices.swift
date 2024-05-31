//
//  GoodsServices.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 02.05.2024.
//

import Foundation

class GoodsServices: NSObject {
    
    var product = [AllGoodsStruct]()
    
    private let allGoodsUrl = "https://rabbitflowers.kz/json/section.php?id="
    let baseUrl = "https://rabbitflowers.kz"

    func downloadAllGoodsFromCategory(categoryID: String, completion: @escaping ((Bool) -> Void)) {
        guard let urlObj = URL(string: "\(allGoodsUrl)\(categoryID)") else {
            completion(false)
            return
        }
        
        guard currentReachabilityStatus != .notReachable else {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: urlObj) { dataOpt, responseOpt, errorOpt in
            guard errorOpt == nil else {
                completion(false)
                return
            }
            
            guard let data = dataOpt  else {
                completion(false)
                return
            }
            
            do {
                self.product = try
                JSONDecoder().decode([AllGoodsStruct].self, from: data)
                completion(true)
            } catch {
                completion(false)
            }
        }.resume()
    }
}
