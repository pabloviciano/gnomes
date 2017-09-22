//
//  LocalGenerator.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation

public class CitizenLocalGenerator: CitizenDataGenerator {
    init() {
        
    }
    public func getData(completion: @escaping (String?) -> Void) {
        completion(try! String(contentsOfFile: Bundle.main.path(forResource: "data", ofType: "json")!))
    }
}
