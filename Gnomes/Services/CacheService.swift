//
//  CacheService.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 20/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit
import Alamofire

public protocol CacheService {
    func insertCitizen(citizen: Citizen)
    func getCitizen(byKey: String) -> Citizen?
    func removeCitizen(citizen: Citizen)
}

public protocol ImageCacheService {
    func getImage(identifier: String, completion: @escaping (UIImage) -> ())
}

public class CacheServiceFactory {
    static func create() -> CacheService {
        return CacheServiceImpl()
    }
    
    static func createImage() -> ImageCacheService {
        return ImageCacheServiceImpl()
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
        return cache[byKey]
    }
    
    public func removeCitizen(citizen: Citizen) {
        cache.removeValue(forKey: citizen.name)
    }
}

internal class ImageCacheServiceImpl: ImageCacheService {
    var imagesCached = [String: ImageCachedObject]()
    private static let maxImages = 25
    
    func getImage(identifier: String, completion: @escaping (UIImage) -> ()) {
        if imagesCached.keys.contains(identifier) {
            completion(imagesCached[identifier]!.image)
        }else {
            if imagesCached.count >= ImageCacheServiceImpl.maxImages {
                let maxOld = imagesCached.values.max(by: { (object, object1) -> Bool in
                    object.date < object1.date
                })
                if let maxOld = maxOld {
                    imagesCached.removeValue(forKey: maxOld.key)
                }
            }
            
            let image = load(byKey: identifier)
            
            if let image = image {
                updateCacheWithImage(image: image, forKey: identifier)
                completion(image)
            }else {
                downloadImage(forKey: identifier, completion: { [unowned self] (image) in
                    self.save(image: image, key: identifier)
                    self.updateCacheWithImage(image: image, forKey: identifier)
                    completion(image)
                })
            }
        }
    }
    
    private func updateCacheWithImage(image: UIImage, forKey key: String) {
        if imagesCached.keys.contains(key) {
            imagesCached.removeValue(forKey: key)
        }
        imagesCached.updateValue(ImageCachedObject(key: key, image: image, date: Date()), forKey: key)
    }
    
    private func downloadImage(forKey key: String, completion: @escaping (UIImage) -> ()) {
        Alamofire.request(URL(string: key)!).responseData { (response) in
            switch(response.result) {
            case let .success(data):
                let image = UIImage(data: data)
                if let image = image {
                    completion(image)
                }
            default:
                return
            }
        }
    }
    
    private func save(image: UIImage, key: String) {
        let dataOpt = UIImagePNGRepresentation(image)
        guard let data = dataOpt else {
            return
        }
        try! data.write(to: getFolder().appendingPathComponent(getFileName(forKey: key)))
    }
    
    private func load(byKey key: String) -> UIImage?{
        let url = getFolder().appendingPathComponent(getFileName(forKey: key))
        do{
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            return image
        }catch {
            return nil
        }
    }
    
    private func getFolder() -> URL {
        let fileManager = FileManager.default
        let docurl = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return docurl
    }
    
    private func getFileName(forKey key: String) -> String {
        return key.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "/", with: "")
    }
}

internal class ImageCachedObject {
    var image: UIImage
    var date: Date
    var key: String
    
    init(key: String, image: UIImage, date: Date) {
        self.key = key
        self.image = image
        self.date = date
    }
}
