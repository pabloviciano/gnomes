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
    
    init(viewController: CitizenTableViewController, viewModel: CitizensViewModel) {
        self.viewController = viewController
        self.viewModel = viewModel
    }
    
    public func presentAlerControllerWith(title: String, message: String) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.viewController.present(alerController, animated: true, completion: nil)
    }
}
