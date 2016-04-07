//
//  ViewController.swift
//  BetTogether
//
//  Created by Viktor on 02/03/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todos: [String]!
    var addToView = AddToViewController()

    @IBOutlet weak var gameTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todos = ["This", "That", "Bajs", "Snopp"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = todos[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todos.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToAdd"{
            let VC = segue.destinationViewController as? AddToViewController
            
            VC?.delegate = self
            
        }
    
        if segue.identifier == "ToShow" {
    
            let VC = segue.destinationViewController as? ShowController
    
            if let cell = sender as? UITableViewCell {
                if let indexPath = gameTableView.indexPathForCell(cell){
                    VC?.teams = todos[indexPath.row]
                }
    }
    }
    }
    
    func addGame(homeTeam: String, awayTeam: String){
        
        todos.append("\(homeTeam) vs \(awayTeam)")
        gameTableView.reloadData()
        
    }



}

