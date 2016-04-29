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
    //var image: String
    let betKey: String
    
    let ref: Firebase?
    
    init(name: String){
        self.name = name
        self.betKey = ""
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot){
        name = snapshot.value["name"] as! String
       ref = snapshot.ref
        betKey = snapshot.key
        
    }
    
    func toAnyObject() -> AnyObject{
        return ["name": name, "betKey":betKey]
    
    }

}