//
//  DetailViewController.swift
//  challenge1
//
//  Created by Cassie Wallace on 10/10/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    func createCountryLabel(_ country: String) -> String {
        let countryText = country.dropLast(4)
        let countryLabel = countryText.count == 2 ? countryText.uppercased() : countryText.capitalized
        return countryLabel
    }
    
    // TODO: Add sharing.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            title = createCountryLabel(imageToLoad)
            
            imageView?.image = UIImage(named: imageToLoad)
        }
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.pngData() else {
                print("No image found")
                return
        }
        
        let vc = UIActivityViewController(activityItems: [image as Any, title ?? ""], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

