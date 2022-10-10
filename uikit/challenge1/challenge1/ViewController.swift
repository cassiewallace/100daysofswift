//
//  ViewController.swift
//  challenge1
//
//  Created by Cassie Wallace on 10/10/22.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                countries.append(item)
            }
        }
        
        countries = countries.sorted()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
            
            let countryText = countries[indexPath.row].dropLast(4)
            cell.textLabel?.text = countryText.count == 2 ? countryText.uppercased() : countryText.capitalized
            cell.imageView?.image = UIImage(named: countries[indexPath.row])
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
