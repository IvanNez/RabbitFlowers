//
//  MenuClass.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 25.04.2024.
//

import Foundation

class MenuClass {
    
    var category = [SectionMenu]()
    
    init() {
        setup()
    }
    
    
    func setup() {
        category.append(SectionMenu(titleSection: "Профиль", items: [ItemMenu(id: 1, title: "Профиль", description: "Настройка оплаты, доставки, времени и данных о клиенте", image: "person.fill")]))
        category.append(SectionMenu(titleSection: "Доставка", items: [ItemMenu(id: 2, title: "Список доставки", description: "Список отслеживания доставки", image: "list.clipboard.fill")]))
        category.append(SectionMenu(titleSection: "О приложении", items: [ItemMenu(id: 3, title: "О приложении", description: "Информация о приложении", image: "exclamationmark.circle.fill")]))
        category.append(SectionMenu(titleSection: "Магазины", items: [ItemMenu(id: 4, title: "Магазины", description: "Информация о наших магазинах, адреса, карта", image: "map.fill")]))
        category.append(SectionMenu(titleSection: "Контакты", items: [ItemMenu(id: 5, title: "Контакты", description: "87057761728 Call-центр", image: "phone.bubble.fill")]))
        category.append(SectionMenu(titleSection: "О компании", items: [ItemMenu(id: 6, title: "О компании", description: "Информация о компании", image: "person.3.fill")]))
        category.append(SectionMenu(titleSection: "Галерея", items: [ItemMenu(id: 7, title: "Галерея фотографий", description: "Галерея фотографий", image: "person.3.fill")]))
    }
    
}
