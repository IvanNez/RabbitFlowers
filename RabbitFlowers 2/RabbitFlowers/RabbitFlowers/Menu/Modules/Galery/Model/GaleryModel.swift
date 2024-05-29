//
//  GaleryModel.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 28.05.2024.
//

import Foundation

class GaleryModel: NSObject {
    
    var images = [PhotoGalleryStruct]()
    let urlRequest = "https://rabbitflowers.kz/json/photogallery.php"
    
    func downloadImage(loaded: @escaping ((Bool) -> Void)) {
        
        guard let urlObj = URL(string: urlRequest) else {
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
                self.images = try
                JSONDecoder().decode([PhotoGalleryStruct].self, from: data)
                loaded(true)

            } catch {
                loaded(false)

            }
            
            self.images = self.images.map({ el in
                PhotoGalleryStruct(id: el.id, url: "https://rabbitflowers.kz/\(el.url)"
            )})
        }.resume()
    }
}
