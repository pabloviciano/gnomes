//
//  CacheServiceTests.swift
//  GnomesTests
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import XCTest

class CacheServiceTests: XCTestCase {
    
    func test_insert_object_is_inside() {
        let cacheService = CacheServiceFactory.create()
        let citizen = CitizenMock()
        cacheService.insertCitizen(citizen: citizen)
        XCTAssertNotNil(cacheService.getCitizen(byKey: citizen.name))
    }
    
    func test_get_citizen_without_insert_is_nil(){
        let cacheService = CacheServiceFactory.create()
        XCTAssertNil(cacheService.getCitizen(byKey: ""))
    }
    
    func test_remove_citizen_not_inside(){
        let cacheService = CacheServiceFactory.create()
        let citizen = CitizenMock()
        cacheService.insertCitizen(citizen: citizen)
        cacheService.removeCitizen(citizen: citizen)
        XCTAssertNil(cacheService.getCitizen(byKey: citizen.name))
    }
}

class CitizenMock: Citizen {
    var id: Int = 0
    
    var name: String = ""
    
    var thumbnail: String = ""
    
    var age: Int = 0
    
    var weight: Double = 0.0
    
    var height: Double = 0.0
    
    var hairColor: String = ""
    
    var professions: [String] = []
    
    var friends: [String] = []
}
