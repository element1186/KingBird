//
//  PicSumDatabase.swift
//  KingBird
//
//  Created by Sergey on 05.04.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import Foundation
import RealmSwift

class PicSumDatabase: Object {
    @objc dynamic var image = Data()
    @objc dynamic var url = ""
    
    class func saveData(object: Object){
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
    }
    
    class func getData() -> Results<PicSumDatabase> {
        let realm = try! Realm()
        return realm.objects(PicSumDatabase.self)
    }
    
    class func delete(object: Object){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
}
