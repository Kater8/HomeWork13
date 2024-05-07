//
//  DataLoaderService.swift
//  Lesson13HW
//

//

import Foundation

enum CustomError: Error {
    case someError
}

class DataLoaderService {
    
    func loadCatalog(completion: @escaping (Catalog?) -> ()) {
        
        guard let url = Bundle.main.url(
            forResource: Constant.catalogFileName,
            withExtension: Constant.json
        ) else {
            assertionFailure()
            completion(nil)
            return
        }
        
        var catalog: Catalog?
        
        do {
            let data = try Data(contentsOf: url)
            catalog = try JSONDecoder().decode(Catalog.self, from: data)
        } catch {
            debugPrint("error:\(error)")
        }
        
        completion(catalog)
    }
}

private enum Constant {
    
    static let catalogFileName = "Catalog"
    static let json = "json"
}
