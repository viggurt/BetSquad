//
//  FirebaseService.swift
//  BetSquad
//
//  Created by Viktor on 15/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    let root: Firebase
    var authID:String? { return root.authData.uid }
    
    //Endpoints
    var users:Firebase { return root.childByAppendingPath("users") }
    var items:Firebase { return root.childByAppendingPath("items")}
    
    init(rootRef:String){
        root = Firebase(url: rootRef)
    }
    
    
    //Tar in email, password
    func registerUserWithEmail(email: String, password: String, completion: (Bool) -> Void){
        
        //Skapar användare i firebsae
        //Om fel, meddela
        //Annars gör något annat
        root.createUser(email, password: password) { (error: NSError!, result: [NSObject: AnyObject]!) in
            
            guard error == nil else {
                
                print("It did not work")
                print(error.description)
                completion(false)
                return
            }
            
            print("User registered")
            self.users.childByAppendingPath(result["uid"] as! String).setValue(["email": email])
            completion(true)
            
            
            
        }
        
    }
    
    func loginUserWithEmail(email: String, password: String, completion:(Bool) -> Void) {
        
        root.authUser(email, password: password) { (error: NSError!, authData:FAuthData!) in
            
            guard error == nil else{
                print("It did not work")
                completion(false)
                return
            }
            
            print("User logged in")
            completion(true)
            
            
            
        }
        
    }
    
    
    //<#T##((NSError!, [NSObject : AnyObject]!) -> Void)!##((NSError!, [NSObject : AnyObject]!) -> Void)!##(NSError!, [NSObject : AnyObject]!) -> Void#>
}
