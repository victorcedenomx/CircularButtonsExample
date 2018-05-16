//
//  FirstViewController.swift
//  CircularButtonsExample
//
//  Created by Víctor Cedeño on 5/16/18.
//  Copyright © 2018 Víctor Cedeño Naranjo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // MARK: - Private properties
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView(frame: self.view.bounds)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    fileprivate let elements = [Int](1...20)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.registerTableViewClass()
    }
    
    // MARK: - Private functions
    
    fileprivate func instanceOfSecondViewController(elements: Int) {
        let secondViewController = SecondViewController()
        secondViewController.elements = elements
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    fileprivate func setupView() {
        self.view.addSubview(self.tableView)
    }
    
    fileprivate func registerTableViewClass() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableView.Cell.id)
    }
}

// MARK: - UITableViewDataSource

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.Cell.id, for: indexPath)
        let title = self.elements[indexPath.row] == 1 ? "element" : "elements"
        cell.textLabel?.text = "\(self.elements[indexPath.row]) \(title)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let elements = self.elements[indexPath.row]
        self.instanceOfSecondViewController(elements: elements)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
