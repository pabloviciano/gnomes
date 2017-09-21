//
//  Citizen.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import Foundation

public protocol Citizen {
    var id: Int {get}
    var name: String {get}
    var thumbnail: String {get}
    var age: Int {get}
    var weight: Double {get}
    var height: Double {get}
    var hairColor: String {get}
    var professions: [String] {get}
    var friends: [String] {get}
}

extension Equatable where Self:Citizen {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.thumbnail == rhs.thumbnail &&
            lhs.age == rhs.age && lhs.weight == rhs.weight && lhs.height == rhs.height &&
            lhs.hairColor == rhs.hairColor && lhs.professions.elementsEqual(rhs.professions) &&
            lhs.friends.elementsEqual(rhs.friends)
    }
}

public class CitizenFactory{
    static func create(id: Int, name: String, thumbnail: String, age: Int, weight: Double, height: Double, hairColor: String, professions: [String], friends: [String]) -> Citizen {
        return CitizenImpl(id: id, name: name, thumbnail: thumbnail, age: age, weight: weight, height: height, hairColor: hairColor, professions: professions, friends: friends)
    }
}

internal class CitizenImpl: Citizen {
    
    public var id: Int {
        get {
            return _id
        }
    }
    public var name: String {
        get {
            return _name
        }
        
    }
    public var thumbnail: String {
        get {
            return _thumbnail
        }
    }
    public var age: Int {
        get {
            return _age
        }
        
    }
    public var weight: Double {
        get {
            return _weight
        }
    }
    public var height: Double {
        get {
            return _height
        }
    }
    public var hairColor: String {
        get {
            return _hairColor
        }
        
    }
    public var professions: [String] {
        get {
           return _professions
        }
    }
    public var friends: [String] {
        get {
            return _friends
        }
    }
    
    private var _id: Int
    private var _name: String
    private var _thumbnail: String
    private var _age: Int
    private var _weight: Double
    private var _height: Double
    private var _hairColor: String
    private var _professions: [String]
    private var _friends: [String]
    
    init(id: Int, name: String, thumbnail: String, age: Int, weight: Double, height: Double, hairColor: String, professions: [String], friends: [String]) {
        self._id = id
        self._name = name
        self._thumbnail = thumbnail
        self._age = age
        self._weight = weight
        self._height = height
        self._hairColor = hairColor
        self._professions = [String](professions)
        self._friends = [String](friends)
    }
}
