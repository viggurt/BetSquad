//
//  LoggedInViewController.swift
//  BetSquad
//
//  Created by Viktor on 15/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase

class LoggedInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Referensen till Firebase URL
    let ref = Firebase(url: "https://betsquad.firebaseio.com/Groups")

    //MARK: Variabler
    var createdGroups: [CreateGroup] = []
    var chosenGroup = 0
    var choosenGroup: CreateGroup?
    
    
    @IBOutlet var groupTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //Visar vägen i Firebase
        ref.childByAppendingPath(ref.authData.uid).observeEventType(.Value, withBlock: {
            snapshot in
            var groups: [CreateGroup] = []
            
            for item in snapshot.children {
                let group = CreateGroup(snapshot: item as! FDataSnapshot)
                
                groups.append(group)
            }
            self.createdGroups = groups
            
            self.groupTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: TableView egenskaper
    
    //Funktion för hur många rader denna TableView ska ha
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createdGroups.count
    }
    
    //Funktion för vilken cell du väljer
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenGroup = indexPath.row
    }
    
    //Funktion för vad som ska stå i cellen
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath) as! CustomCell
        
        
        cell.groupName.text = "\(createdGroups[indexPath.row].name)"
        
        return cell
    }

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //Funktion för att swipea en cell åt höger så kan man deleta den gruppen
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            if let tv = groupTableView
            {
                
                
                
                let ref = createdGroups.removeAtIndex(indexPath.row)
                ref.ref?.removeValue()
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                
                
            }
        }
    }
    
    //Förbereder för att visa de placerade spelen i gruppen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GroupView" {
        
            let VC = segue.destinationViewController as? ViewController
            
            if let cell = sender as? UITableViewCell {
                if let indexPath = groupTableView.indexPathForCell(cell){
                    VC?.choosenGroup = createdGroups[indexPath.row]
                }
            }
            
        
        }
    }
    
    
    //MARK: Actions
    
    //Funktion för att logga ut
    @IBAction func logOutButtonWasPressed(sender: UIBarButtonItem) {
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("logInScreen") as! LogInViewController!
        
        self.presentViewController(VC,animated: true, completion: nil)
    }

}
