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
    
    //var pictureLabel: [String] = []
    //var pictures: [UIImage] = []
    var chosenPicutre = 0
    
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupName.delegate = self
        
        /*pictureLabel = ["Fotboll", "Tennis", "Baseball", "Basket", "Dart", "Hockey", "Slumpat"]
        pictures = [UIImage(named:"boll1.png")!, UIImage(named: "tennis.png")!, UIImage(named: "baseball.png")!, UIImage(named: "basket.png")!, UIImage(named: "dart.png")!, UIImage(named: "hockey.png")!, UIImage(named: "randomSport.png")!]*/
        
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
    
    /*func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenPicutre = indexPath.row
        imagePicked.image = pictures[indexPath.row]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("pictureCell", forIndexPath: indexPath) as! SportCell
        
        cell.sportPicture.image = pictures[indexPath.row]
        cell.sportLabel.text! = "\(pictureLabel[indexPath.row])"
        return cell
    }*/
    

    @IBAction func selectPhotoButtonWasPressed(sender: AnyObject) {
        
    }
    
    
    
    
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
