//
//  LocImage.swift
//  LocationTA
//
//  Created by DaninMac on 19.01.22.
//

import Foundation
import FirebaseDatabase

struct LocImage {
    
    let key: String!
    let url: String!
    
    let itemRef: DatabaseReference?
    
    init(url: String, key: String) {
        self.key  = key
        self.url = url
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let imageUrl = snapshotValue?["url"] as? String {
            url = imageUrl
        } else {
            url = ""
        }
        
    }
    
}
