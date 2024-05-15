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
    
    // ДЗ - заполнить все категории
    func setup() {
        category.append(SectionMenu(titleSection: "Доставка", items: [ItemMenu(id: 1, title: "Доставка", description: "Доставка покупателям", image: "shippingbox.fill"), ItemMenu(id: 2, title: "Время доставки", description: "Отслеживание доставки", image: "clock.fill"), ItemMenu(id: 3, title: "Список доставки", description: "Список отслеживания доставки", image: "list.clipboard.fill")]))
        category.append(SectionMenu(titleSection: "Оплата", items: [ItemMenu(id: 2, title: "Оплата", description: "Оплата покупателям", image: "creditcard.fill")]))
        category.append(SectionMenu(titleSection: "Компания", items: [ItemMenu(id: 2, title: "Компания", description: "Информация о компании", image: "")]))
        category.append(SectionMenu(titleSection: "Акции", items: [ItemMenu(id: 2, title: "Акции", description: "Новые акции", image: "giftcard.fill")]))
        category.append(SectionMenu(titleSection: "Магазины", items: [ItemMenu(id: 2, title: "Магазины", description: "Информация о наших магазинах", image: "cart.fill.badge.questionmark")]))
        category.append(SectionMenu(titleSection: "Контакты", items: [ItemMenu(id: 2, title: "Контакты", description: "Наши контакты", image: "phone.bubble.fill")]))
        category.append(SectionMenu(titleSection: "Статьи и обзоры", items: [ItemMenu(id: 2, title: "Статьи и обзоры", description: "Статьи и обзоры", image: "tray.fill")]))
        category.append(SectionMenu(titleSection: "Новости", items: [ItemMenu(id: 2, title: "Новости", description: "Новости магазина", image: "newspaper.fill")]))
        category.append(SectionMenu(titleSection: "Цены", items: [ItemMenu(id: 2, title: "Цены", description: "Информация о ценах", image: "creditcard.circle.fill")]))
        category.append(SectionMenu(titleSection: "Фотогалерея", items: [ItemMenu(id: 2, title: "Фотогалерея", description: "Фото букетов", image: "photo.on.rectangle.angled")]))
    }
    
}
