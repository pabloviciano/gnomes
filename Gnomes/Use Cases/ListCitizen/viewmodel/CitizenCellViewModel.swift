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
    
    init(citizen: Citizen, imageCacheService: ImageCacheService) {
        self.citizen = citizen
        self.imageCacheService = imageCacheService
    }
    
    public var name: String {
        get {
            return citizen.name
        }
    }
    
    public func load() {
        self.imageCacheService.getImage(identifier: citizen.thumbnail) { [unowned self] (image) in
            guard let view = self.view else {
                return
            }
            view.onLoad(withImage: image)
        }
    }
}
