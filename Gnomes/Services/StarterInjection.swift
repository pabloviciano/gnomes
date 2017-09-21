//
//  StarterInjection.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit

public class StarterInjection {
    public static func initiate() -> CitizensRouter {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: CitizenTableViewController.StoryboardId) as! CitizenTableViewController
        let viewModel = CitizensViewModel(view: viewController, citizenGenerator: CitizenLocalGenerator(), imageCacheService: CacheServiceFactory.createImage())
        viewController.viewModel = viewModel
        let router = CitizensRouter(viewController: viewController, viewModel: viewModel)
        viewModel.router = router
        return router
    }
}
