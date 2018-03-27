//
//  SegmentedControl.swift
//
//  Created by Dmytro on 11/24/17.
//  Copyright © 2017 Dmytro Cheverda. All rights reserved.
//

import UIKit

public class SegmentedControl: UIControl {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return view
    }()
    
    private var underlineViewLeadingConstraint: NSLayoutConstraint!
    private let fontSize: CGFloat = 15.0
    
    private var selectedButton: UIButton? {
        didSet {
            guard let button = selectedButton else { return }
            
            // Update button isSelected state
            for view in stackView.arrangedSubviews {
                guard let button = view as? UIButton else { continue }
                button.isSelected = false
            }
            button.isSelected = true
            
            // Animate underline position
            if let buttonIndex = stackView.arrangedSubviews.index(of: button) {
                selectedIndex = buttonIndex
                sendActions(for: .valueChanged)
                
                let animationDuration: TimeInterval = underlineView.frame == CGRect.zero ? 0 : 0.15
                UIView.animate(withDuration: animationDuration, animations: {
                    self.underlineViewLeadingConstraint.constant = CGFloat(buttonIndex) * button.frame.width
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    // MARK: - Public Properties
    
    public private(set) var selectedIndex = 0
    
    public var items: [String] = [] {
        didSet {
            removeStackViewSubviews()
            
            // Add UIButton for each item
            for title in items {
                let button = UIButton(type: .custom)
                button.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(button)
                setupButtonItem(button, withTitle: title)
            }
            
            // Initial configure for first button
            if let button = stackView.arrangedSubviews.first as? UIButton {
                underlineView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

                underlineViewLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: button.leadingAnchor)
                underlineViewLeadingConstraint.isActive = true
                
                underlineView.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                
                selectedButton = button
            }
        }
    }
    
    public var underlineColor = UIColor.blue {
        didSet {
            underlineView.backgroundColor = underlineColor
        }
    }
    public var textDefaultColor = UIColor.gray {
        didSet {
            updateButtonsAppearance()
        }
    }
    public var textSelectedColor = UIColor.darkGray {
        didSet {
            updateButtonsAppearance()
        }
    }
    
    // MARK: - Lifecycle
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(underlineView)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override public var isEnabled: Bool {
        didSet {
            stackView.arrangedSubviews.forEach({
                if let button = $0 as? UIButton {
                    button.isEnabled = isEnabled
                }
            })
        }
    }
    
    // MARK: - Setup
    
    private func setupButtonItem(_ button: UIButton, withTitle title: String) {
        let normalAttrs: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: fontSize),
                                                         .foregroundColor: textDefaultColor]
        let selectedAttrs: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize),
                                                           .foregroundColor: textSelectedColor]
        
        button.setAttributedTitle(NSAttributedString(string: title, attributes: normalAttrs), for: .normal)
        button.setAttributedTitle(NSAttributedString(string: title, attributes: selectedAttrs), for: .selected)
        button.backgroundColor = UIColor.clear
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    // MARK: - Private
    
    private func removeStackViewSubviews() {
        stackView.arrangedSubviews.forEach({
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
    }
    
    @objc private func buttonPressed(_ button: UIButton) {
        guard button != selectedButton else { return }
        selectedButton = button
    }
    
    private func updateButtonsAppearance() {
        for subview in stackView.arrangedSubviews {
            guard let button = subview as? UIButton else { return }
            
            setupButtonItem(button, withTitle: button.currentAttributedTitle?.string ?? "Undefined")
        }
    }
}
