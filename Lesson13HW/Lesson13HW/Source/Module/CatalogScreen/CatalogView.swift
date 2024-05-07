//
//  CatalogView.swift
//  Lesson13HW
//

//

import UIKit

protocol CatalogViewDelegate: AnyObject {
    
}

class CatalogView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: CatalogViewDelegate?
}
