//
//  ViewController.swift
//  project1
//
//  Created by Cassie Wallace on 10/7/22.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadImages), with: nil)
        
        collectionView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureCell
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.totalImageCount = pictures.count
            vc.currentImageNumber = indexPath.row + 1
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures = pictures.sorted()
    }

    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Check out Storm Viewer on the App Store!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

// MARK: - Table view code for reference
// override func viewDidLoad() {
//     super.viewDidLoad()
//
//     title = "Storm Viewer"
//     navigationController?.navigationBar.prefersLargeTitles = true
//     navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
//
//     performSelector(inBackground: #selector(loadImages), with: nil)
//
//     tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
// }
//
// override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return pictures.count
// }
//
// override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//     let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//     cell.textLabel?.text = pictures[indexPath.row]
//     return cell
// }
//
// override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//     if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//         vc.selectedImage = pictures[indexPath.row]
//         vc.totalImageCount = pictures.count
//         vc.currentImageNumber = indexPath.row + 1
//
//         navigationController?.pushViewController(vc, animated: true)
//     }
// }
