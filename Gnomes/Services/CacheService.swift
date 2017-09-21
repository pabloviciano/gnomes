//
//  CacheService.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation

public protocol CacheService {
    func insertCitizen(citizen: Citizen)
    func getCitizen(byKey: String) -> Citizen?
    func removeCitizen(citizen: Citizen)
}

public class CacheServiceFactory {
    static func create() -> CacheService {
        return CacheServiceImpl()
    }
}

internal class CacheServiceImpl: CacheService {
    private var cache = [String: Citizen]()
    
    public func insertCitizen(citizen: Citizen) {
        if !cache.keys.contains(citizen.name) {
            cache.updateValue(citizen, forKey: citizen.name)
        }
    }
    
    public func getCitizen(byKey: String) -> Citizen? {
        return cache.values.first(where: { $0.name == byKey })
    }
    
    public func removeCitizen(citizen: Citizen) {
        cache.removeValue(forKey: citizen.name)
    }
}
