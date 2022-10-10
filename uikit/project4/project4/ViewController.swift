//
//  ViewController.swift
//  project4
//
//  Created by Cassie Wallace on 10/10/22.
//

import UIKit

class ViewController: UITableViewController {
    var websites = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Visit The Internet"
        navigationController?.navigationBar.prefersLargeTitles = true

        websites = ["apple.com", "hackingwithswift.com"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
            
            cell.textLabel?.text = websites[indexPath.row]
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewController {
            vc.website = websites[indexPath.row]
            vc.websites = websites
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
