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
    let imageCacheService: ImageCacheService
    let cacheService: CacheService
    
    init(view: CitizensView, citizenGenerator: CitizenDataGenerator, imageCacheService: ImageCacheService, cacheService: CacheService) {
        self.view = view
        self.citizenGenerator = citizenGenerator
        self.imageCacheService = imageCacheService
        self.cacheService = cacheService
    }
    
    public func name() -> String {
        return "Gnomes"
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
        return CitizenCellViewModel(citizen: citizens[index], imageCacheService: imageCacheService, cacheService: cacheService)
    }
    
    public func load() {
        CitizenParser.parse(generator: self.citizenGenerator, cacheService:  self.cacheService) { (result) in
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
    
    public func selectCitizen(at index: Int) {
        guard let router = router, let citizens = citizens, index >= 0 && index < citizens.count else {
            return
        }
        router.navigateToDetailCitizen(citizen: citizens[index])
    }
    

    
}
