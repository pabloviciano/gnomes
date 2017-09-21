//
//  NetworkService.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkService {
    
    struct Constants {
        static let URL = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
        
    }
    
    static let singleton = NetworkService()
    
    public func fetchData(completion: @escaping ()->Void){
        
    }
}


