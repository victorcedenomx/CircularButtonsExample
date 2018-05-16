//
//  SecondViewController.swift
//  CircularButtonsExample
//
//  Created by Víctor Cedeño on 5/16/18.
//  Copyright © 2018 Víctor Cedeño Naranjo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var elements: Int!
    
    // MARK: - Private properties
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView(frame: self.view.bounds)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.registerTableViewClass()
    }
    
    // MARK: - Private functions
    
    fileprivate func setupView() {
        self.view.addSubview(self.tableView)
    }
    
    fileprivate func registerTableViewClass() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableView.Cell.id)
    }
    
    fileprivate func getRowHeight() -> CGFloat {
        let height = Constants.Screen.height - Constants.Screen.statusBarHeight - Constants.Screen.statusBarHeight
        
        switch self.numberOFRows() {
        case 1:
            return height
        case 2:
            return height / 2
        default:
            switch self.elements {
            case 3...8:
                return height / (CGFloat(self.elements / 2) + CGFloat(self.elements % 2))
            default:
                return height / 4
            }
        }
    }
    
    fileprivate func numberOFRows() -> Int {
        let div = self.elements / 2
        let mod = self.elements % 2
        
        switch self.elements {
        case 2:
            return self.elements
        default:
            return mod == 0 ? div : div + mod
        }
    }
}

// MARK: - UITableViewDataSource

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOFRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SecondTableViewCell(style: .default, reuseIdentifier: Constants.TableView.Cell.id)
        cell.position = Position(index: indexPath.row + 1, elements: self.elements)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getRowHeight()
    }
}
