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
       //return CitizensRouter(citizenGenerator: CitizenLocalGenerator(), cacheService: CacheServiceFactory.create(), imageCacheService: CacheServiceFactory.createImage())
        return CitizensRouter(citizenGenerator: NetworkGenerator(), cacheService: CacheServiceFactory.create(), imageCacheService: CacheServiceFactory.createImage())
    }
}
