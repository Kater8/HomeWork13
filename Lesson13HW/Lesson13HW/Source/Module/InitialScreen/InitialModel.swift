//
//  InitialModel.swift
//  Lesson13HW
//

//

import Foundation

protocol InitialModelDelegate: AnyObject {
    
    func titlesDidLoad(titles: [String])
}

class InitialModel {
    
    weak var delegate: InitialModelDelegate?
    
    func loadTitles() {
        
        let titles = [
            "START",
            "DO",
            "ACHIEVE"
        ]
        
        delegate?.titlesDidLoad(titles: titles)
    }
}
