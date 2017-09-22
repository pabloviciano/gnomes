//
//  DetailCitizenRouter.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 22/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation
import UIKit

public class DetailCitizenRouter {
    var viewController: DetailCitizenViewController
    var viewModel: DetailCitizenViewModel
    var previousRouter: CitizensRouter
    
    init(citizen: Citizen, cacheService: CacheService, imageCacheService: ImageCacheService, previousRouter: CitizensRouter) {
        let storyboard = UIStoryboard(name: "DetailCitizen", bundle: Bundle.main)
        self.viewController = storyboard.instantiateViewController(withIdentifier: DetailCitizenViewController.StoryboardId) as! DetailCitizenViewController
        self.viewModel = DetailCitizenViewModel(view: self.viewController, citizen: citizen, imageCacheService: imageCacheService, cacheService: cacheService)
        self.viewController.viewModel = self.viewModel
        self.previousRouter = previousRouter
        self.viewModel.router = self
    }
    
    public func navigateToDetailViewController(){
        guard let navigationController = self.previousRouter.viewController.navigationController else {
            return
        }
        navigationController.pushViewController(self.viewController, animated: true)
    }
}
