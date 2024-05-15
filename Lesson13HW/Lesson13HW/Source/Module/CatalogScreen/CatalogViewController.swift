//
//  CatalogViewController.swift
//  Lesson13HW
//

//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var contentView: CatalogView!
    var model: CatalogModel!
    
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
        
        title = "Catalog"
        
        model = CatalogModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
    }
}

// MARK: - CatalogModelDelegate
extension CatalogViewController: CatalogModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - CatalogViewDelegate
extension CatalogViewController: CatalogViewDelegate {
    
}

// MARK: - CustomCellDelegate
extension CatalogViewController: CustomCatalogCellDelegate {
    func didTapFavourite(_ isFavourite: Bool, itemId: Int) {
        model.updateItem(with: isFavourite, by: itemId)
    }
}

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pcItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell") as? CustomCatalogCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        let item = model.pcItems[indexPath.row]
        cell.setup(with: item)
        cell.setFavourite(item.favorite())
        cell.delegate = self
        return cell
    }
}

// MARK: CustomCatalogCell
class CustomCatalogCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: CustomCatalogCellDelegate?
    
    private var itemId: Int = 0
    private var isFavourite: Bool = false
    
    func setup(with item: Pc) {
        self.itemId = item.id
        self.idLabel.text = String(item.id)
        self.priceLabel.text = "\(item.price) \(item.currency)"
        self.nameLabel.text = item.name
        self.detailLabel.text = "\(item.manufacturer) \(item.model)"
      
    }
    
    func setFavourite(_ isFavourite: Bool) {
        let image: UIImage? = isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favouriteButton.setImage(image, for: .normal)
        self.isFavourite = isFavourite
    }
    
  
    
    @IBAction func favouriteAction(_ sender: UIButton) {
        /// let newValue = !isFavourite
        let newValue = !isFavourite
        /// change isFavourite
        setFavourite(newValue)
        /// change icon (setFavourite)
        delegate?.didTapFavourite(newValue, itemId: itemId)
        /// call delegate
    }
}

protocol CustomCatalogCellDelegate: AnyObject {
    func didTapFavourite(_ isFavourite: Bool, itemId: Int)
}
