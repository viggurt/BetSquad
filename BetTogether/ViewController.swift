//
//  ViewController.swift
//  BetTogether
//
//  Created by Viktor on 02/03/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var placedBets: [PlacedBet] = []
    var addToView = AddToViewController()
    var choosenBet: PlacedBet?
    
    let ref = Firebase(url: "https://betsquad.firebaseio.com/Placed%20Bet")

    @IBOutlet weak var gameTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            var bets: [PlacedBet] = []
            
            for item in snapshot.children {
                let bet = PlacedBet(snapshot: item as! FDataSnapshot)
                
                bets.append(bet)
            }
            self.placedBets = bets
            self.gameTableView.reloadData()
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
        
        let title = "\(placedBets[indexPath.row].homeTeam) - \(placedBets[indexPath.row].awayTeam)"
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return placedBets.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToAdd"{
            let VC = segue.destinationViewController as? AddToViewController
            
            VC?.delegate = self
            
        }
        
        var memberIndex: Int
        
        if let cell = sender as? UITableViewCell {
            if let indexPathRow = gameTableView.indexPathForCell(cell) {
                memberIndex = indexPathRow.row
                self.choosenBet = placedBets[memberIndex]
            }
    
        if segue.identifier == "ToShow" {
    
            /*let VC = segue.destinationViewController as? ShowController
    
            if let cell = sender as? UITableViewCell {
                if let indexPath = gameTableView.indexPathForCell(cell){
                    VC?.teams = title
                }*/
            
            
                    if let controller = segue.destinationViewController as? ShowController {
                        controller.choosenBet = self.choosenBet
                    }
                }
            }
    }
}
    
    
    /*func addGame(homeTeam: String, awayTeam: String){
        
        todos.append("\(homeTeam) vs \(awayTeam)")
        gameTableView.reloadData()
        
    }*/





