//
//  ShowController.swift
//  BetTogether
//
//  Created by Viktor on 08/03/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase

class ShowController: UIViewController {
    
    let VC = ViewController()
    
    let ref = Firebase(url: "https://betsquad.firebaseio.com/Groups/Placed%20Bet/")
    
    //MARK: Outlets
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var betTypeLabel: UILabel!
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var unitImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var analysText: UITextView!
    
    //var teams: String?
    //var betType: String?
    var choosenBet: PlacedBet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Sätter alla värden från det valda bettet
        dateLabel.text = choosenBet!.date

        teamLabel.text = "\(choosenBet!.homeTeam) - \(choosenBet!.awayTeam)"
        
        oddsLabel.text = "\(choosenBet!.odds)"
        
        analysText.text = "\(choosenBet!.analys)"
        analysText.textColor = UIColor.whiteColor()
        
        print(choosenBet!.betKey)
        
        //Bet typen
        
        if choosenBet!.bet == "1" {
            betTypeLabel.text = choosenBet!.homeTeam
        }
        else if choosenBet!.bet == "2" {
            betTypeLabel.text = choosenBet!.awayTeam
        }
        else if choosenBet!.bet == "X" {
            betTypeLabel.text = "Oavgjort"
        }
        else{
            betTypeLabel.text = choosenBet!.bet
        }
        
        //Sport bilden
        
        if choosenBet!.sport == "Fotboll" {
            sportImageView.image = UIImage(named: "boll1")
        }
        else if choosenBet!.sport == "Tennis" {
            sportImageView.image = UIImage(named: "tennis")
        }
        else if choosenBet!.sport == "Dart" {
            sportImageView.image = UIImage(named: "dart")
        }
        else if choosenBet!.sport == "Basket" {
            sportImageView.image = UIImage(named: "basket")
        }
        else if choosenBet!.sport == "Hockey" {
            sportImageView.image = UIImage(named: "hockey")
        }
        else if choosenBet!.sport == "Baseball" {
            sportImageView.image = UIImage(named: "baseball")
        }
        //Bolag bilden
        
        if choosenBet!.company == "bet365" {
            companyImageView.image = UIImage(named: "bet365")
        }
        else if choosenBet!.company == "unibet" {
            companyImageView.image = UIImage(named: "unibet")
        }
        else if choosenBet!.company == "betfair" {
            companyImageView.image = UIImage(named: "betfair")
        }
        else{
            companyLabel.text = choosenBet!.company
            companyLabel.hidden = false
        }
        
        //Unit
        
        if choosenBet!.unit == 1{
            unitImageView.image = UIImage(named: "unit1")
        }
        else if choosenBet!.unit == 2 {
        unitImageView.image = UIImage(named: "unit2")
        }
        else if choosenBet!.unit == 3{
        unitImageView.image = UIImage(named: "unit3")
        }
        else if choosenBet!.unit == 4{
        unitImageView.image = UIImage(named: "unit4")
        }
        else if choosenBet!.unit == 5{
        unitImageView.image = UIImage(named: "unit5")
        }
        
        
        
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
   

}
