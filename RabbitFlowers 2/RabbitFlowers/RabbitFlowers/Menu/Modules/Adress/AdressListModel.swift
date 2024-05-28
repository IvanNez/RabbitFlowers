//
//  AdressListModel.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 28.05.2024.
//

import Foundation
import MapKit

class AdressListModel {
    var adress = [PinDataStruct]()
    
    init() {
        loadAdress()
    }
    
    func loadAdress() {
        adress.append(PinDataStruct(adress: "​Проспект Туран, 37, цокольный этаж", loc: CLLocationCoordinate2D(latitude: 51.133506, longitude: 71.403275)))
        adress.append(PinDataStruct(adress: "Проспект Кабанбай батыр, 62", loc: CLLocationCoordinate2D(latitude: 51.089634, longitude: 71.404946)))
        adress.append(PinDataStruct(adress: "Улица Динмухамед Конаев, 12/2", loc: CLLocationCoordinate2D(latitude: 51.127396, longitude: 71.430541)))
    }
}
