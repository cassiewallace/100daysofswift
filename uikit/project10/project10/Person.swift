//
//  Person.swift
//  project10
//
//  Created by Cassie Wallace on 10/12/22.
//

import UIKit

class Person: NSObject {

    // MARK: Var(s)
    var name: String
    var image: String
    var id: UUID
    
    // MARK: Init(s)
    init(name: String, image: String) {
        self.name = name
        self.image = image
        self.id = UUID()
    }
    
}
