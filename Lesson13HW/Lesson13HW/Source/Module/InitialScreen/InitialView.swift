//
//  InitialView.swift
//  Lesson13HW
//

//

import UIKit

protocol InitialViewDelegate: AnyObject {
    
    func didFinishAnimating()
}

class InitialView: UIView {
    
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    weak var delegate: InitialViewDelegate?
    
    private var titleIndx = 0
    private var titles: [String] = []
    
    func setup(with titles: [String]) {
        self.titles = titles
    }
    
    func startAnimation() {
        if let title = getNextText() {
            animateText(title)
        }
    }
    
    private func animateText(_ text: String) {
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            
            let label = self.getLabel(with: text)
            self.descriptionStackView.addArrangedSubview(label)

            self.layoutIfNeeded()
            
        } completion: { finished in
            
            if finished {
                if let title = self.getNextText() {
                    self.animateText(title)
                } else {
                    self.delegate?.didFinishAnimating()
                }
            }
        }
    }
    
    private func getLabel(with text: String) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }
    
    private func getNextText() -> String? {
        
        guard (0 ..< titles.count) ~= titleIndx else { return nil }
        
        let text = titles[titleIndx]
        titleIndx += 1
        
        return text
    }
}
