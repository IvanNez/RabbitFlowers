//
//  AllStructures.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 23.04.2024.
//

import Foundation

// MARK: -- For Menu

struct SectionMenu {
    var titleSection: String?
    var items: [ItemMenu]
}

struct ItemMenu {
    var id: Int
    var title: String
    var description: String
    var image: String?
}

// MARK: -- ALL categories

struct AllCategoriesStruct: Decodable {
    var id: String
    var name: String
    var picture: String?
}

// MARK: -- Banner

struct BannerStruct: Decodable {
    var id: String
    var name: String
    var picture: String?
    var desription: String
}

// MARK: -- Product
struct AllGoodsStruct: Decodable {
    var id: String
    var id_section: String
    var name: String
    var price: String
    var description: String?
    var picture: String?
}

// MARK: -- Order send
struct DataSend: Codable {
    var id: String
    var name: String
    var phone: String
    var adress: String
    var note: String
    var sum: String
    var date: String
    var paymentType: Bool = true
}

struct DataResponse: Decodable {
    var result: String
    var orderid: Int
}
