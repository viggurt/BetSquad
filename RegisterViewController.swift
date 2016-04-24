//
//  RegisterViewController.swift
//  BetSquad
//
//  Created by Viktor on 15/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let fireService = FirebaseService(rootRef: "https://betsquad.firebaseio.com/")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func registerButtonWasPressed(sender: UIButton) {
        
        if let email = emailTextField.text, password = passwordTextField.text {
            
            registerButton.backgroundColor = UIColor.blueColor()
            
            fireService.registerUserWithEmail(email, password: password) {(passed:Bool) in
                
                if passed == true {
                    self.registerButton.backgroundColor = UIColor.greenColor()
                    self.navigationController?.popViewControllerAnimated(true)
                }
                else{
                    self.registerButton.backgroundColor = UIColor.redColor()
                }
                
            }
        }

    }

}
