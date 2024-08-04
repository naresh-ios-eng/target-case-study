//
//  ActionView.swift
//  ProductViewer
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

/// This class is used to add action to any view. The action must be defined in the Action enum
final class ActionView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var actionsStackView: UIStackView!
    
    /// Need to add the actions like addToCard, add to watch list etc
    var actions: [Action] = []
    
    private var productModel: ProductModel?
    weak var delegate: ActionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    static func initialise(actions: [Action], delegate: ActionViewDelegate?) -> ActionView {
        guard let actionView = Bundle.main.loadNibNamed(ActionView.id, owner: nil)?.first as? ActionView else {
            fatalError("Not initialised")
        }
        actionView.actions = actions
        actionView.delegate = delegate
        actionView.setupUI()
        return actionView
    }

    
    private func updateContent() {
        //self.productImageView.image = UIImage.init(data: )
    }
    
    public func setupUI() {
        /// Adding the action buttons
        for action in actions {
            let button = UIButton.init()
            button.tag = action.rawValue
            button.setTitle(action.title, for: .normal)
            button.titleLabel?.font = action.buttonFont.font
            button.tintColor = UIColor(hex: action.titleColor)
            button.backgroundColor = UIColor(hex: action.buttonBackgroundColor) 
            button.addTarget(self, action: #selector(didActionTrigged(sender:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.actionsStackView.addArrangedSubview(button)
            let heightConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
            button.addConstraint(heightConstraint)
        }
        
        /// Marking the top corner radius
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        
    }
    
    @objc func didActionTrigged(sender: UIButton) {
        guard let action = Action.init(rawValue: sender.tag) else { return }
        self.delegate?.didTriggeredAction(action: action)
    }
}

extension ActionView: IdentityProvidable {
    static var id: String {
        return "ActionView"
    }
}
