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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    @IBAction func logInButtonWasPressed(sender: UIButton) {
        if let email = emailTextField.text, password = passwordTextField.text{
            sender.backgroundColor = UIColor.blueColor()
            
            fireService.loginUserWithEmail(email, password: password) {(passed:Bool) in
                
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
                else{
                    sender.backgroundColor = UIColor.redColor()
                }
            }
            
        }
    }

    
    @IBAction func registerButtonWasPressed(sender: UIButton) {
    }
    

}
