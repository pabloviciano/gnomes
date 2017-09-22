//
//  NetworkService.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation
import Alamofire

class NetworkGenerator: CitizenDataGenerator {
    struct Constants {
        static let URL = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
    }
    public func getData(completion: @escaping (String?)->Void){
        Alamofire.request(URL(string: Constants.URL)!).responseString { (response) in
            switch response.result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(String(describing: error))
            }
        }
    }
}


