//
//  Location.swift
//  LocationTA
//
//  Created by DaninMac on 19.01.22.
//

import Foundation
import FirebaseDatabase

struct Location {
    
    let key: String!
    let loactionName: String!
    let itemRef: DatabaseReference?
    
    init(loactionName: String, key: String) {
        self.key  = key
        self.loactionName  = loactionName
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let locName = snapshotValue?["loactionName"] as? String {
            loactionName = locName
        } else {
            loactionName = ""
        }
        
    }
    
}
