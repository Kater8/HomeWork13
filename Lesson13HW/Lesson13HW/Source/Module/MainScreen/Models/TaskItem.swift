//
//  TaskItem.swift
//  Lesson13HW
//

//

import Foundation

enum TaskItemType: Int {
    case catalog
    case favorite
    case none
}

struct TaskItem {
    
    let titleText: String
    let descriptionText: String
    let type: TaskItemType
}
