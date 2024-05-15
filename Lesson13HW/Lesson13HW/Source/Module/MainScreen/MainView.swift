//
//  MainView.swift
//  Lesson13HW
//

//

import UIKit

protocol MainViewDelegate: AnyObject {
    
}

class MainView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MainViewDelegate?
}
