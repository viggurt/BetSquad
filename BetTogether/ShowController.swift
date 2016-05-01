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
    
    //MARK: Variabler
    var choosenBet: PlacedBet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    //MARK: Values
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
        
        sportImageView.image = UIImage(named: choosenBet!.sport)
        
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
