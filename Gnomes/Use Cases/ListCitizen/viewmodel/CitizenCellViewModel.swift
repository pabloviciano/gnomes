//
//  CitizenCellViewModel.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

public class CitizenCellViewModel {
    private var citizen: Citizen
    var view: CitizenCellView? = nil
    
    init(citizen: Citizen) {
        self.citizen = citizen
    }
    
    public var name: String {
        get {
            return citizen.name
        }
    }
    
    public func load() {
        Alamofire.request(URL(string: citizen.thumbnail)!).responseImage { (response) in
            print(response)
            
            switch(response.result){
            case let .success(value):
                guard let view = self.view else {
                    return
                }
                view.onLoad(withImage: value)
            default:
                return
            }
        }
        
    }
}
