//
//  LocalStorageService.swift
//  Lesson13HW
//

//

import Foundation

class LocalStorageService {
    
    func saveFavorites(_ favorites: [Favorite]) {
        
        do {
            let jsonData = try JSONEncoder().encode(favorites)
            if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(Constant.favoriteFileName).\(Constant.json)") {
                try jsonData.write(to: fileURL)
                debugPrint("Favorite file was saved to: \(fileURL.path)")
            }
        } catch {
            assertionFailure()
        }
    }
    
    func getFavorites() -> [Favorite] {
        
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(Constant.favoriteFileName).\(Constant.json)")
        else {
            assertionFailure("Unable to get url")
            return []
        }

        do {
            let jsonData = try Data(contentsOf: fileURL)
            let result = try JSONDecoder().decode([Favorite].self, from: jsonData)
            return result
        } catch {
            return []
        }
    }
    
    func clearFavorites() {
        
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(Constant.favoriteFileName).\(Constant.json)")
        else {
            assertionFailure("Unable to get url")
            return
        }

        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            return
        }
    }
}

private enum Constant {
    
    static let favoriteFileName = "Favorite"
    static let json = "json"
}
