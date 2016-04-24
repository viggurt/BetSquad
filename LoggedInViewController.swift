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
    
    let ref = Firebase(url: "https://betsquad.firebaseio.com/Groups")

    var createdGroups: [CreateGroup] = []
    var chosenGroup = 0
    
    
    
    @IBOutlet var groupTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createdGroups.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenGroup = indexPath.row
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath) as! CustomCell
        
        
        cell.groupName.text = "\(createdGroups[indexPath.row].name)"
        cell.groupImage.image = UIImage(named: "\(createdGroups[indexPath.row].image)")
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
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
    
    
    @IBAction func logOutButtonWasPressed(sender: UIBarButtonItem) {
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("logInScreen") as! LogInViewController!
        
        self.presentViewController(VC,animated: true, completion: nil)
    }

}
