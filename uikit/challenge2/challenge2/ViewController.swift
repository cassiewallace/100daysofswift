//
//  ViewController.swift
//  challenge2
//
//  Created by Cassie Wallace on 10/11/22.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingListItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return shoppingListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
            cell.textLabel?.text = shoppingListItems[indexPath.row]
            return cell
    }

    @objc func promptForItem() {
        let ac = UIAlertController(title: "Add item to list", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak ac, weak self] _ in
                guard let newItem = ac?.textFields?[0].text else { return }
                self?.addItem(newItem)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func addItem(_ item: String) {
        shoppingListItems.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @objc func clearList() {
        shoppingListItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

}
