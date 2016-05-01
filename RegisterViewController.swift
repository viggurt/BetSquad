//
//  RegisterViewController.swift
//  BetSquad
//
//  Created by Viktor on 15/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //Referens till Firebase URL
    let fireService = FirebaseService(rootRef: "https://betsquad.firebaseio.com/")
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    }
    //MARK: Actions
    
    //Registrerings knappen blev aktiverad
    @IBAction func registerButtonWasPressed(sender: UIButton) {
        
        if let email = emailTextField.text, password = passwordTextField.text {
            
            //Knappen blir blå medans den undersöker informationen
            registerButton.backgroundColor = UIColor.blueColor()
            
            fireService.registerUserWithEmail(email, password: password) {(passed:Bool) in
                
                //Om informationen är korrekt så blir knappen grön
                if passed == true {
                    self.registerButton.backgroundColor = UIColor.greenColor()
                    self.navigationController?.popViewControllerAnimated(true)
                }
                    
                //Annars blir knappen röd
                else{
                    self.registerButton.backgroundColor = UIColor.redColor()
                }
                
            }
        }

    }

}
