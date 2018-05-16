//
//  SecondTableViewCell.swift
//  CircularButtonsExample
//
//  Created by Víctor Cedeño on 5/16/18.
//  Copyright © 2018 Víctor Cedeño Naranjo. All rights reserved.
//

import UIKit

enum ButtonType {
    case center
    case left
    case right
}

struct Position {
    var index: Int
    var elements: Int
}

class SecondTableViewCell: UITableViewCell {
    
    // MARK: - Internal properties
    
    var position: Position! {
        didSet {
            self.setupButtons(index: position.index, rows: position.elements)
        }
    }
    
    // MARK: - Private properties
    
    fileprivate lazy var leftButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var centerButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var rightButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    fileprivate func getRowHeight() -> CGFloat {
        let height = Constants.Screen.height - Constants.Screen.statusBarHeight - Constants.Screen.statusBarHeight
        
        switch self.numberOFRows() {
        case 1:
            return height
        case 2...3:
            return height / 2
        default:
            return height / 3
        }
    }
    
    fileprivate func setupCell() {
        self.selectionStyle = .none
    }
    
    fileprivate func setupButtons(index: Int, rows: Int) {
        let width = Constants.Screen.width
        var size: CGFloat
        
        switch rows {
        case 1:
            size = width * 0.75
            
            self.addButton(button: self.centerButton, buttonType: .center, size: size)
            break
        case 2:
            let margin = width / 8
            size = self.getRowHeight() * 0.5
            
            if index < rows {
                self.addButton(button: self.leftButton, buttonType: .left, margin: margin, size: size)
            } else {
                self.addButton(button: self.rightButton, buttonType: .right, margin: margin, size: size)
            }
            break
        case 3:
            let margin = width / 12
            size = self.getRowHeight() * 0.4
            
            if index < self.numberOFRows() {
                self.addButton(button: self.leftButton, buttonType: .left, margin: margin, size: size)
                self.addButton(button: self.rightButton, buttonType: .right, margin: margin, size: size)
            } else {
                self.addButton(button: self.centerButton, buttonType: .center, size: size)
            }
            break
        default:
            let margin = width / 12
            let isEven = self.position.elements % 2 == 0
            size = self.getRowHeight() * 0.4
            
            if isEven {
                self.addButton(button: self.leftButton, buttonType: .left, margin: margin, size: size)
                self.addButton(button: self.rightButton, buttonType: .right, margin: margin, size: size)
            } else {
                if index < self.numberOFRows() {
                    self.addButton(button: self.leftButton, buttonType: .left, margin: margin, size: size)
                    self.addButton(button: self.rightButton, buttonType: .right, margin: margin, size: size)
                } else {
                    self.addButton(button: self.centerButton, buttonType: .center, size: size)
                }
            }
            break
        }
    }
    
    fileprivate func numberOFRows() -> Int {
        let div = self.position.elements / 2
        let mod = self.position.elements % 2
        
        switch self.position.elements {
        case 2:
            return self.position.elements
        default:
            return mod == 0 ? div : div + mod
        }
    }
    
    fileprivate func addButton(button: UIButton, buttonType: ButtonType, margin: CGFloat = 0, size: CGFloat) {
        self.addSubview(button)
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: size).isActive = true
        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        button.layer.cornerRadius = size / 2
        
        switch buttonType {
        case .center:
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            break
        case .left:
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
            break
        case .right:
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
            break
        }
    }
}
