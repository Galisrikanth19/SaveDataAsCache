//
//  DashboardVC.swift
//  SaveDataAsCache
//
//  Created by Webappclouds on 11/10/22.
//

import UIKit
import Cache

class DashboardVC: UIViewController {
    let cacheKey = "keyName"
    var storage: Storage<String, UserModel> {
        let diskConfig = DiskConfig(name: "LocalDisk")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        let storage = try! Storage<String, UserModel>(
                  diskConfig: diskConfig,
                  memoryConfig: memoryConfig,
                  transformer: TransformerFactory.forCodable(ofType: UserModel.self))
        return storage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveUserDetails(_ sender: UIButton) {
        let userM = UserModel(firstName: "John", lastName: "Snow")
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
