//
//  MainPlaylistView.swift
//  Lesson13HW
//

//

import UIKit

protocol FavoriteViewDelegate: AnyObject {
    
}

class FavoriteView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FavoriteViewDelegate?
}
