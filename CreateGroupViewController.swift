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
    
    let ref = Firebase(url: "https://betsquad.firebaseio.com/")
    
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var groupName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupName.delegate = self
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
    @IBAction func selectPhotoButtonWasPressed(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func createGroupButtonWasPressed(sender: UIButton) {
        let name = groupName.text!
    
        
        let group = CreateGroup(name: name, image: "\(imagePicked.image!)")
        
        let groupRef = ref.childByAppendingPath("Groups")
        let groupIdRef = groupRef.childByAppendingPath(ref.authData.uid).childByAutoId()
        
        groupIdRef.setValue(group.toAnyObject())
        
        navigationController?.popViewControllerAnimated(true)
    }

}
