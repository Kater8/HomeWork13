//
//  FavoriteViewController.swift
//  Lesson13HW
//

//

import UIKit

class FavoriteViewController: UIViewController, FavoriteViewDelegate {
    
    @IBOutlet weak var contentView: FavoriteView!
    var model: FavoriteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.saveChangesIfNeeded()
    }
    
    private func setupInitialState() {
        
        title = "Favorite"
        
        model = FavoriteModel()
        model.delegate = self
        
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

// MARK: - FavoriteModelDelegate
extension FavoriteViewController: FavoriteModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}




// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? CustomFavoriteCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = model.favoriteItems[indexPath.row]
        cell.setup(with: item)
       
        return cell
    }
}
//
//// MARK: FavoriteViewController
extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            видалення
            let deletedItem = model.favoriteItems.remove(at: indexPath.row)
            // оновлення
            tableView.deleteRows(at: [indexPath], with: .automatic)
            model.saveChangesIfNeeded()
            tableView.reloadData()
        }
    }
}


// MARK: CustomCell
class CustomFavoriteCell: UITableViewCell {
    @IBOutlet weak var idL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var modelL: UILabel!
    
    weak var delegate: FavoriteViewDelegate?
    
    
    private var itemId: Int = 0
    
    func setup(with item: Favorite) {
        self.itemId = item.id
        self.idL.text = "\(item.id)"
        self.nameL.text = item.name
        self.modelL.text = "\(item.manufacturer) \(item.model)"
    }
}
    
