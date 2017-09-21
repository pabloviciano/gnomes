//
//  LocalGenerator.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation

class CitizenLocalGenerator: CitizenDataGenerator {
    var getData: String {
        get {
            return try! String(contentsOfFile: Bundle.main.path(forResource: "data", ofType: "json")!)
        }
    }
}
