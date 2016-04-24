//
//  CreateGroup.swift
//  BetSquad
//
//  Created by Viktor on 21/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import Firebase

class CreateGroup{
    let name: String
    let image: String
    let betKey: String
    
    let ref: Firebase?
    
    init(name: String, image: String){
        self.name = name
        self.betKey = ""
        self.image = image
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot){
        name = snapshot.value["name"] as! String
        image = snapshot.value["image"] as! String
       ref = snapshot.ref
        betKey = snapshot.key
        
    }
    
    func toAnyObject() -> AnyObject{
        return ["name": name, "image": image, "betKey":betKey]
    
    }

}