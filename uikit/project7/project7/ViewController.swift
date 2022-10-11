//
//  ViewController.swift
//  project7
//
//  Created by Cassie Wallace on 10/11/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var displayedPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Petitions"
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptSearch))
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
        
        func parse(json: Data) {
            let decoder = JSONDecoder()

            if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
                petitions = jsonPetitions.results
                displayedPetitions = petitions
                tableView.reloadData()
            }
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = displayedPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = displayedPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "We The People API", message: "This data was provided by the White House's We The People API, which is now deprecated.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func promptSearch() {
        let ac = UIAlertController(title: "Search for petitions", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        
        let searchAction = UIAlertAction(title: "Search", style: .default) {
            [weak ac, weak self] _ in
            guard let searchTerm = ac?.textFields?[0].text else { return }
            self?.search(searchTerm)
        }
        
        ac.addAction(searchAction)
        present(ac, animated: true)
    }
    
    func search(_ searchTerm: String) {
        let lowerTerm = searchTerm.lowercased()
    
        displayedPetitions = petitions.filter { $0.title.lowercased().contains(lowerTerm) || $0.body.lowercased().contains(lowerTerm) }

        tableView.reloadData()
    }

}
