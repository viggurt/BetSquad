//
//  CreateGroupViewController.swift
//  BetSquad
//
//  Created by Viktor on 21/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Referens till Firebase URL
    let ref = Firebase(url: "https://betsquad.firebaseio.com/")
    var chosenPicutre = 0
    
    //MARK: Outlets
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupName.delegate = self
        
        //Funktion för att toggla ner tangentbordet när man klickar på bakgrunden
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Funktion för att toggla ner tangentbordet när man klickar på bakgrunden
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Skapa grupp-knappen blev tryckt på
    @IBAction func createGroupButtonWasPressed(sender: UIButton) {
        let name = groupName.text!
        if name != "" {
        
        let group = CreateGroup(name: name)        
        
        let groupRef = ref.childByAppendingPath("Groups")
        let groupIdRef = groupRef.childByAppendingPath(ref.authData.uid).childByAutoId()
        
        groupIdRef.setValue(group.toAnyObject())
        
        navigationController?.popViewControllerAnimated(true)
        }
        else{
           errorLabel.hidden = false
        }
    }

}
