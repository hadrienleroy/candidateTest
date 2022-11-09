//
//  ViewController.swift
//  Candidate
//
//  Created by Hadrien LEROY on 24/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var goalView: GoalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        goalView.setup(viewModel: GoalViewModel(availability: .init(minDate: Date(), maxDate: Date().addingTimeInterval(1000)),
                                                minOdds: 1.0,
                                                minStake: 1.0,
                                                event: "Finale - Roland Garros",
                                                source: .bet,
                                                dateFormatter: DateFormatter()))
    }
}

extension UIView {

    func instantiateNib() {
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: Bundle.main)
        let nibInstance = nib.instantiate(withOwner: self, options: nil)
        guard let contentView = nibInstance.first as? UIView else {
            return
        }
        self.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        NSLayoutConstraint.activate(layoutAttributes.map { attribute in
          NSLayoutConstraint(
            item: contentView, attribute: attribute,
            relatedBy: .equal,
            toItem: self, attribute: attribute,
            multiplier: 1, constant: 0.0
          )
        })
    }
}
