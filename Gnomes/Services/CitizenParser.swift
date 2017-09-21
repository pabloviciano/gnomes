//
//  CitizenParser.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation
import Result

public protocol CitizenDataGenerator {
    var getData: String { get }
}

class CitizenParser {
    static func parse(generator: CitizenDataGenerator, cacheService: CacheService? = nil, completion:@escaping (Result<[Citizen], CitizenParserErrors>) -> Void) {
        do {
            let jsonOpt = try JSONSerialization.jsonObject(with: generator.getData.data(using: .utf8)!) as? [String: Any]
            guard let json = jsonOpt else {
                return completion(.failure(CitizenParserErrors.BadFormat))
            }
            guard let citizens = json["Brastlewark"] as? [[String:Any]] else {
                return completion(.failure(CitizenParserErrors.BadFormat))
            }
            var citizensArray = [Citizen]()
            for citizenData in citizens {
                switch CitizenParser.parseCitizen(data: citizenData){
                case let .success(citizen):
                    citizensArray.append(citizen)
                    if let cacheService = cacheService {
                        cacheService.insertCitizen(citizen: citizen)
                    }
                default:
                    continue
                }
            }
            completion(.success(citizensArray))
        } catch  {
            completion(.failure(CitizenParserErrors.BadFormat))
        }
    }
    
    static func parseCitizen(data: [String:Any]) -> Result<Citizen, CitizenParserErrors> {
        guard let id = data["id"] as? Int else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let name = data["name"] as? String else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let thumbnail = data["thumbnail"] as? String else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let age = data["age"] as? Int else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let weight = data["weight"] as? Double else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let height = data["height"] as? Double else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let hairColor = data["hair_color"] as? String else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let professions = data["professions"] as? [String] else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        guard let friends = data["friends"] as? [String] else {
            return .failure(CitizenParserErrors.BadFormat)
        }
        return .success(CitizenFactory.create(id: id, name: name, thumbnail: thumbnail, age: age, weight: weight, height: height, hairColor: hairColor, professions: professions, friends: friends))
        
    }
}

enum CitizenParserErrors: Error {
    case BadFormat
}
