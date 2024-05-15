//
//  InitialViewController.swift
//  Lesson13HW
//

//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var contentView: InitialView!
    var model: InitialModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadTitles()
    }
    
    // Інтерфс вже показано на екрані - викликається ця функція автоматично
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.startAnimation()
    }
    
    // Функція початкових налаштувань
    private func setupInitialState() {
        
        model = InitialModel()
        model.delegate = self
        
        contentView.delegate = self
    }
}

// MARK: - InitialModelDelegate
extension InitialViewController: InitialModelDelegate {
    
    func titlesDidLoad(titles: [String]) {
        contentView.setup(with: titles)
    }
}

// MARK: - InitialViewDelegate
extension InitialViewController: InitialViewDelegate {
    
    func didFinishAnimating() {
        
        guard let mainVc = MainViewController.fromMainStoryboard() else { return }
        navigationController?.setViewControllers([mainVc], animated: false)
    }
}
