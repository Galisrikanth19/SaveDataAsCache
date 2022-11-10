//
//  ViewController.swift
//  SaveDataAsCache
//
//  Created by Webappclouds on 11/10/22.
//

import UIKit
import Cache

class ViewController: UIViewController {
    let cacheKey = "keyName"
    var storage: Storage<String, User> {
        let diskConfig = DiskConfig(name: "LocalDisk")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        let storage = try! Storage<String, User>(
                  diskConfig: diskConfig,
                  memoryConfig: memoryConfig,
                  transformer: TransformerFactory.forCodable(ofType: User.self))
        return storage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveUserDetails(_ sender: UIButton) {
        let userM = User(firstName: "John", lastName: "Snow")
        do {
            try self.storage.setObject(userM, forKey: cacheKey)
        } catch {
            print(error)
        }
    }
    
    @IBAction func fetchUserDetails(_ sender: UIButton) {
        do {
            let userM = try self.storage.object(forKey: cacheKey)
            print(userM.firstName ?? "")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct User: Codable {
  let firstName: String?
  let lastName: String?
}
