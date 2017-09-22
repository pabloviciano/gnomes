//
//  DetailCitizenViewModel.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 22/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit

public enum DataSource: Int {
    case jobs = 0
    case friends = 1
}

public class DetailCitizenViewModel {
    let citizen: Citizen
    let imageCacheService: ImageCacheService
    let cacheService: CacheService
    let view: DetailCitizenView
    var router: DetailCitizenRouter? = nil
    
    init(view: DetailCitizenView, citizen: Citizen, imageCacheService: ImageCacheService, cacheService: CacheService) {
        self.citizen = citizen
        self.imageCacheService = imageCacheService
        self.cacheService = cacheService
        self.view = view
    }
    
    public func load() {
        self.imageCacheService.getImage(identifier: self.citizen.thumbnail) { [unowned self] (image) in
            DispatchQueue.main.async {
                self.image = image
                self.view.onLoad()
            }
        }
    }
    
    public var image: UIImage?
    
    public var name: String {
        get {
            return citizen.name
        }
    }
    
    public var age: String {
        get {
            return String(format: "%d years", citizen.age)
        }
    }
    
    public var weight: String {
        get {
            return String(format: "%.02f kg", citizen.weight)
        }
    }
    
    public var height: String {
        get {
            return String(format: "%.02f cm", citizen.height)
        }
    }
    
    public var hairColor: String {
        get {
            return citizen.hairColor
        }
    }
    
    public var numOfSections: Int {
        get{
            return 2
        }
    }
    
    public func sectionTitleOn(section: Int) -> String {
        let dataSourceOpt = DataSource(rawValue: section)
        guard let dataSource = dataSourceOpt else {
            return ""
        }
        switch dataSource {
        case .jobs:
            return "Jobs"
        case .friends:
            return "Friends"
        }
    }
    
    public func numberOfItemsOn(section: Int) -> Int {
        let dataSourceOpt = DataSource(rawValue: section)
        guard let dataSource = dataSourceOpt else {
            return 0
        }
        switch dataSource {
        case .jobs:
            return citizen.professions.count
        case .friends:
            return citizen.friends.count
        }
    }

    public func job(at index: Int) -> JobCellViewModel? {
        guard index >= 0 && index < citizen.professions.count else {
            return nil
        }
        return JobCellViewModel(job: citizen.professions[index])
    }
    
    
    public func friend(at index: Int) -> CitizenCellViewModel? {
        guard index >= 0 && index < citizen.friends.count else {
            return nil
        }
        let friend = self.citizen.friends[index]
        guard let citizen = self.cacheService.getCitizen(byKey: friend) else {
            return nil
        }
        return CitizenCellViewModel(citizen: citizen, imageCacheService: imageCacheService, cacheService: cacheService)
    }
    
    public func selectFrient(at index: Int) {
        guard index >= 0 && index < citizen.friends.count else {
            return
        }
        let friend = self.citizen.friends[index]
        guard let citizen = self.cacheService.getCitizen(byKey: friend) else {
            return
        }
        DetailCitizenRouter(citizen: citizen, cacheService: cacheService, imageCacheService: imageCacheService, previousRouter: self.router!.previousRouter).navigateToDetailViewController()
    }
}
