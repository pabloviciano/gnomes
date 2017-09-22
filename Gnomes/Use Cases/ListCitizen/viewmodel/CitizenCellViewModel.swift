//
//  CitizenCellViewModel.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit
import Alamofire

public class CitizenCellViewModel {
    private let citizen: Citizen
    var view: CitizenCellView? = nil
    let imageCacheService: ImageCacheService
    let cacheService: CacheService
    
    init(citizen: Citizen, imageCacheService: ImageCacheService, cacheService: CacheService) {
        self.citizen = citizen
        self.imageCacheService = imageCacheService
        self.cacheService = cacheService
    }
    
    public var name: String {
        get {
            return citizen.name
        }
    }
    
    public func load() {
        DispatchQueue.global(qos: .utility).async { 
            self.imageCacheService.getImage(identifier: self.citizen.thumbnail) { [weak self] (image) in
                guard let viewModel = self,  let view = viewModel.view else {
                    return
                }
                DispatchQueue.main.async {
                    view.onLoad(withImage: image)
                }
            }
        }
        
    }
}
