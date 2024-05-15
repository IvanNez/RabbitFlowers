//
//  MainClass.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 23.04.2024.
//

import Foundation

class MainClass: NSObject {
    
    var allCategories = [AllCategoriesStruct]()
    var banners = [BannerStruct]()
    
    private let categoryString = "https://rabbitflowers.kz/json/catalog.php"
    private let bannerString = "https://rabbitflowers.kz/json/banners.php"
    let baseUrl = "https://rabbitflowers.kz"
    
    func downloadJsonForCategories(loaded: @escaping ((Bool, String) -> Void)) {
        
        guard let urlObj = URL(string: categoryString) else {
            loaded(false, "Bad url")
            return
        }
        
        guard currentReachabilityStatus != .notReachable else {
            loaded(false, "Not internet connection")
            return
        }
        
        URLSession.shared.dataTask(with: urlObj) { dataOpt, responseOpt, errorOpt in
            guard errorOpt == nil else {
                loaded(false, "We have an error")
                return
            }
            
            guard let data = dataOpt  else {
                loaded(false, "Data faild")
                return
            }
            
            
            do {
                self.allCategories = try
                JSONDecoder().decode([AllCategoriesStruct].self, from: data)
                loaded(true, "Finished")

                
            } catch {
                loaded(false, error.localizedDescription)

            }
                        
        }.resume()
        
   
    }
    
    func downloadBanner(loaded: @escaping ((Bool) -> Void)) {
        
        guard let urlObj = URL(string: bannerString) else {
            loaded(false)
            return
        }
        
        guard currentReachabilityStatus != .notReachable else {
            loaded(false)
            return
        }
        
        URLSession.shared.dataTask(with: urlObj) { dataOpt, responseOpt, errorOpt in
            guard errorOpt == nil else {
                loaded(false)
                return
            }
            
            guard let data = dataOpt  else {
                loaded(false)
                return
            }
            
            
            do {
                self.banners = try
                JSONDecoder().decode([BannerStruct].self, from: data)
                loaded(true)

            } catch {
                loaded(false)

            }
                        
        }.resume()
    }
}
