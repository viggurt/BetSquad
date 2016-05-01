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
    
    //Variabler
    let name: String
    let betKey: String
    
    //Referens till Firebase
    let ref: Firebase?
    
    init(name: String){
        self.name = name
        self.betKey = ""
        self.ref = nil
    }
    
    //Samlar datan i Firebase
    init(snapshot: FDataSnapshot){
        name = snapshot.value["name"] as! String
       ref = snapshot.ref
        betKey = snapshot.key
        
    }
    
    func toAnyObject() -> AnyObject{
        return ["name": name, "betKey":betKey]
    
    }

}