//
//  LogInViewController.swift
//  BetSquad
//
//  Created by Viktor on 15/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Referens till Firebase URL
    let fireService = FirebaseService(rootRef: "https://betsquad.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Funktion för att toggla ner tangentbordet när man klickar på bakgrunden
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    
    //Funktion för att toggla ner tangentbordet när man klickar på bakgrunden
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Logga in-knappen blev aktiverad
    @IBAction func logInButtonWasPressed(sender: UIButton) {
        if let email = emailTextField.text, password = passwordTextField.text{
            
            //Knappen blir blå medans den kollar om infon är korrekt
            sender.backgroundColor = UIColor.blueColor()
            
            fireService.loginUserWithEmail(email, password: password) {(passed:Bool) in
                
                //Om infon stämmer så blir knappen grön och man loggas in
                if passed == true{
                    if let id = self.fireService.authID {
                        self.fireService.users.childByAppendingPath(id).observeEventType(.Value) { (data:FDataSnapshot!) in
                            
                            print(data.value)
                            
                            
                        }
                    }
                    let VC = self.storyboard?.instantiateViewControllerWithIdentifier("logged") as! UINavigationController!
                    
                    self.presentViewController(VC,animated: true, completion: nil)
                    
                    sender.backgroundColor = UIColor.greenColor()
                }
                    //Annars blir knappen röd
                else{
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            
        }
    }
}
