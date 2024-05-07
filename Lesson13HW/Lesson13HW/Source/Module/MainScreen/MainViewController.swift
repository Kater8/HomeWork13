//
//  MainViewController.swift
//  Lesson13HW
//

//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainView!
    var model: MainModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

// MARK: - MainModelDelegate
extension MainViewController: MainModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell")
        else {
            return UITableViewCell()
        }
        
        let item = model.sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.titleText
        cell.detailTextLabel?.text = item.descriptionText
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = model.sections[indexPath.section].items[indexPath.row].type
        var vc: UIViewController?
        
        switch type {
        case .catalog:
            vc = CatalogViewController.fromMainStoryboard()
        case .favorite:
            vc = FavoriteViewController.fromMainStoryboard()
        case .none: break
        }
        
        guard let viewController = vc else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
