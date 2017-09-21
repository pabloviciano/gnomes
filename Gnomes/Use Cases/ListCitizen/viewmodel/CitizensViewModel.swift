//
//  CitizensViewModel.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation
import Result

class CitizensViewModel {
    let view: CitizensView
    var citizens: [Citizen]? = nil
    let citizenGenerator: CitizenDataGenerator
    var router: CitizensRouter? = nil
    
    init(view: CitizensView, citizenGenerator: CitizenDataGenerator) {
        self.view = view
        self.citizenGenerator = citizenGenerator
    }
    
    public func numberOfCitizens() -> Int {
        guard let citizens = citizens else {
            return 0
        }
        return citizens.count
    }
    
    public func citizenAt(index: Int) -> CitizenCellViewModel? {
        guard let citizens = citizens, index >= 0 && index < citizens.count else {
            return nil
        }
        return CitizenCellViewModel(citizen: citizens[index])
    }
    
    public func load() {
        CitizenParser.parse(generator: self.citizenGenerator) { (result) in
            switch(result){
                case let .success(citizens):
                    self.citizens = citizens
                    self.view.onLoadEvent()
            case let .failure(error):
                guard let router = self.router else {
                    return
                }
                router.presentAlerControllerWith(title: "Error", message: String(describing: error))
            }
        }
    }
    
}
