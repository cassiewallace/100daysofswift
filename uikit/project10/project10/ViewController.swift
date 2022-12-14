//
//  ViewController.swift
//  project10
//
//  Created by Cassie Wallace on 10/12/22.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var people = [Person]()

	override func viewDidLoad() {
		super.viewDidLoad()
  
        title = "Names to Faces"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return people.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell

		let person = people[indexPath.item]

		cell.name.text = person.name

		let path = getDocumentsDirectory().appendingPathComponent(person.image)
		cell.imageView.image = UIImage(contentsOfFile: path.path)

		cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		cell.imageView.layer.borderWidth = 2
		cell.imageView.layer.cornerRadius = 3
		cell.layer.cornerRadius = 7

		return cell
	}

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let person = people[indexPath.item]
        promptOptions(person)
	}

	@objc func addNewPerson() {
		let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
		picker.delegate = self
        
		present(picker, animated: true)
	}

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.originalImage] as? UIImage else { return }

		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
			try? jpegData.write(to: imagePath)
		}

		let person = Person(name: "Unknown", image: imageName)
		people.append(person)
		collectionView?.reloadData()
        
		dismiss(animated: true)
	}

	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
 
    func promptOptions(_ person: Person) {
		let ac = UIAlertController(title: person.name, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Rename", style: .default) { action in self.promptRename(person) })
		ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { action in self.promptDelete(person) })
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
		present(ac, animated: true)
    }
 
    func promptRename(_ person: Person) {
		let ac = UIAlertController(title: "Rename \(person.name)", message: nil, preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
			let newName = ac.textFields![0]
			person.name = newName.text!
			self.collectionView?.reloadData()
		})

		present(ac, animated: true)
    }
    
    func promptDelete(_ person: Person) {
		let ac = UIAlertController(title: "Delete \(person.name)", message: "Are you sure? This can't be undone.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default) { action in self.delete(person) })
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

		present(ac, animated: true)
    }
    
    func delete(_ person: Person) {
        if let index = people.firstIndex(where: { $0.id == person.id }) {
            people.remove(at: index)
            collectionView.reloadData()
        } else {
            print("Delete failed")
        }
    }
    
}
