//
//  Playlist.swift
//  Lesson13HW
//

//

import Foundation

struct Catalog: Decodable {
    
    let data: [Pc]
}

struct Pc: Codable, Hashable {
    
    let id: Int
    let name: String
    let manufacturer: String
    let model: String
    let rating: Int
    let price: Int
    let currency: String
    let topSelling: Int
    
    var isFavorite: Bool? = false
    
    func favorite() -> Bool {
        return isFavorite ?? false
    }
}
