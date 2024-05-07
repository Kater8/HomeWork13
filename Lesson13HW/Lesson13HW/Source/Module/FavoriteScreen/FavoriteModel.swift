//
//  MainPlaylistModel.swift
//  Lesson13HW
//

//

import Foundation

protocol FavoriteModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class FavoriteModel {

    weak var delegate: FavoriteModelDelegate?
    private let localStorage = LocalStorageService()
    
    var favoriteItems: [Favorite] = []
    
    func loadData() {
        
        favoriteItems = localStorage.getFavorites()
        delegate?.dataDidLoad()
    }
    
    func removeFromFavorite(at index: Int) {
        favoriteItems.remove(at: index)
    }
    
    func saveChangesIfNeeded() {
        
        guard !favoriteItems.isEmpty 
        else {
            localStorage.clearFavorites()
            return
        }
        
        let savedItems = localStorage.getFavorites()
        guard savedItems != favoriteItems else { return }
        
        localStorage.saveFavorites(favoriteItems)
    }
}
