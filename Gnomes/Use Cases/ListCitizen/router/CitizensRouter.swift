//
//  CitizensRouter.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation
import UIKit

public class CitizensRouter {
    var viewController: CitizenTableViewController
    var viewModel: CitizensViewModel
    
    init(citizenGenerator: CitizenDataGenerator, cacheService: CacheService, imageCacheService: ImageCacheService) {
        
        let storyboard = UIStoryboard(name: "ListCitizen", bundle: Bundle.main)
        self.viewController = storyboard.instantiateViewController(withIdentifier: CitizenTableViewController.StoryboardId) as! CitizenTableViewController
        self.viewModel = CitizensViewModel(view: viewController, citizenGenerator: CitizenLocalGenerator(), imageCacheService: CacheServiceFactory.createImage(), cacheService: CacheServiceFactory.create())
        self.viewController.viewModel = viewModel
        self.viewModel.router = self
    }
    
    public func presentAlerControllerWith(title: String, message: String) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.viewController.present(alerController, animated: true, completion: nil)
    }
    
    public func navigateToDetailCitizen(citizen: Citizen) {
        DetailCitizenRouter(citizen: citizen, cacheService: viewModel.cacheService, imageCacheService: viewModel.imageCacheService, previousRouter: self).navigateToDetailViewController()
    }
}
