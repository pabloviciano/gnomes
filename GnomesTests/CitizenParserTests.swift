//
//  CitizenParserTests.swift
//  GnomesTests
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import XCTest
import Result

class CitizenParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_parse_data_successull() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        CitizenParser.parse(generator: JsonMockCitizenGenerator()) { (result: Result<[Citizen], CitizenParserErrors>) in
            switch result{
            case let .failure(error):
                XCTFail(String(describing: error))
            case let .success(citizens):
                XCTAssertNotNil(citizens)
            }
        }
    }
    
    func test_parse_data_successull_was_1337_citizens() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        CitizenParser.parse(generator: JsonMockCitizenGenerator()) { (result: Result<[Citizen], CitizenParserErrors>) in
            switch result{
            case let .failure(error):
                XCTFail(String(describing: error))
            case let .success(citizens):
                XCTAssertTrue(citizens.count == 1337)
            }
        }
    }
    
    func test_parse_citizen_successfull(){
        let data = ["id":0,"name":"Tobus Quickwhistle","thumbnail":"http://www.publicdomainpictures.net/pictures/10000/nahled/thinking-monkey-11282237747K8xB.jpg","age":306,"weight":39.065952,"height":107.75835,"hair_color":"Pink","professions":["Metalworker","Woodcarver","Stonecarver"," Tinker","Tailor","Potter"],"friends":["Cogwitz Chillwidget","Tinadette Chillbuster"]] as [String : Any]
        let result = CitizenParser.parseCitizen(data: data)
        switch result {
        case let .success(citizen):
            XCTAssertNotNil(citizen)
        case let .failure(error):
            XCTFail(String(describing: error))
        }
    }
    
    func test_parse_citizen_error() {
        let data = ["name":"Tobus Quickwhistle","thumbnail":"http://www.publicdomainpictures.net/pictures/10000/nahled/thinking-monkey-11282237747K8xB.jpg","age":306,"weight":39.065952,"height":107.75835,"hair_color":"Pink","professions":["Metalworker","Woodcarver","Stonecarver"," Tinker","Tailor","Potter"],"friends":["Cogwitz Chillwidget","Tinadette Chillbuster"]] as [String : Any]
        let result = CitizenParser.parseCitizen(data: data)
        switch result {
        case .success:
            XCTFail("citizen was created")
        case .failure:
            XCTAssertTrue(true)
        }
    }
    
    func testMeasureParsing() {
        self.measure {
            CitizenParser.parse(generator: JsonMockCitizenGenerator()) { (result: Result<[Citizen], CitizenParserErrors>) in
            }
        }
    }
}

class JsonMockCitizenGenerator: CitizenDataGenerator {
    var getData: String {
        get {
            return try! String(contentsOfFile: Bundle(for: JsonMockCitizenGenerator.self).path(forResource: "data", ofType: "json")!)
        }
    }
}
