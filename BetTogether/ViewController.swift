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
    
    //MARK: Variabler
    var placedBets: [PlacedBet] = []
    var addToView = AddToViewController()
    var choosenBet: PlacedBet?
    var choosenGroup: CreateGroup?
    
    //Referens till Firebase URL
    let ref = Firebase(url: "https://betsquad.firebaseio.com/Groups/")

    
    //MARK: Outlets
    @IBOutlet weak var gameTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(choosenGroup!.betKey)
    }
    
    //Använder denna funktion för att lätt få åtkomst till nyckeln för gruppen i firebase
    func groupKey() -> String{
    
        return choosenGroup!.betKey
    }
    
    override func viewDidAppear(animated: Bool) {
    
        //Sätter vägen för vart den ska i Firebase
        ref.childByAppendingPath(ref.authData.uid).childByAppendingPath("\(choosenGroup!.betKey)").childByAppendingPath("Placed Bets").observeEventType(.Value, withBlock: {
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
    
    //MARK: TableViewen
    
    //Visar vad som ska stå i cellen
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
        
        let title = "\(placedBets[indexPath.row].bet)"
        
        if title == "1" {
            cell.textLabel?.text = "\(placedBets[indexPath.row].homeTeam)"
        }
        else if title == "2" {
            cell.textLabel?.text = "\(placedBets[indexPath.row].awayTeam)"
        }
        else if title == "X" {
            cell.textLabel?.text = "Oavgjort"
        }
        else{
            cell.textLabel?.text = title
        }
        
        let subtitle = "\(placedBets[indexPath.row].homeTeam) - \(placedBets[indexPath.row].awayTeam)"
        
        
        cell.detailTextLabel?.text = subtitle
        
        return cell
    }
    
    //Visar hur många rader TableViewen ska ha
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return placedBets.count
    }
    
    //Funktion för att lätt ta bort ett placerat spel med en knapp
    @IBAction func exit(segue: UIStoryboardSegue){
        let ref = self.choosenBet?.ref
        ref!.removeValue()
        self.gameTableView.reloadData()
    }
    
    //Förbereder för att lägga till ett spel
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
            //Förbereder för att visa det placerade spelet
        if segue.identifier == "ToShow" {
                    if let controller = segue.destinationViewController as? ShowController {
                        controller.choosenBet = self.choosenBet
                    }
                }
            }
    }
}





