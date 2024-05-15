//
//  MainModel.swift
//  Lesson13HW
//

//

import Foundation

protocol MainModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class MainModel {
    
    class Section {
        var items: [TaskItem] = []
    }
    
    weak var delegate: MainModelDelegate?
    
    var sections: [Section] = []
    
    func loadData() {
        
        let mainSection = Section()
        mainSection.items = [
            TaskItem(
                titleText: "Catalog\n\nЗавдання 1:",
                descriptionText: "- Замінити стандартну комірку на кастомну для відображення інформації ПК згідно дизайну.\n- Додати кнопку Favorite і привʼязати до неї логіку маркування isFavorite",
                type: .catalog
            ),
            TaskItem(
                titleText: "Favorite\n\nЗавдання 2:",
                descriptionText: "- Замінити стандартну комірку на кастомну для відображення інформації Favorite, згідно дизайну.\n- Додати 'swipe to delete' у таблицю і привʼязати до неї логіку видалення з Favorites",
                type: .favorite
            )
        ]
        
        let additionalSection = Section()
        additionalSection.items = [
            TaskItem(
                titleText: "Завдання 3*:",
                descriptionText: "- Якщо переглянути логіку екрану інформації ПК (Catalog), можна побачити баг, що на екрані Catalog не відображаються маркери Favorite, якщо вже було збереження. Необхідно додати логіку на екрані Catalog і зіставити значення для favorites (збережені дані та отримані)",
                type: .none
            )
        ]
        
        self.sections = [mainSection, additionalSection]
        
        delegate?.dataDidLoad()
    }
}
