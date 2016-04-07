//
//  PlacedBet.swift
//  BetTogether
//
//  Created by Viktor on 07/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import Firebase

class PlacedBet {
    let homeTeam: String
    let awayTeam: String
    let sport: String
    let bet: String
    let odds: Double
    let company: String
    let date: String
    let unit: Int
    let analys: String
    
    let ref: Firebase?
    
    init(homeTeam: String, awayTeam: String, sport: String, bet: String, odds: Double, company: String, date: String, unit: Int, analys: String){
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.sport = sport
        self.bet = bet
        self.odds = odds
        self.company = company
        self.date = date
        self.unit = unit
        self.analys = analys
        
        self.ref = nil
        
    }
    
    init(snapshot: FDataSnapshot){
        homeTeam = snapshot.value["homeTeam"] as! String
        awayTeam = snapshot.value["awayTeam"] as! String
        sport = snapshot.value["sport"] as! String
        bet = snapshot.value["bet"] as! String
        odds = snapshot.value["odds"] as! Double
        company = snapshot.value["company"] as! String
        date = snapshot.value["date"] as! String
        unit = snapshot.value["unit"] as! Int
        analys = snapshot.value["analys"] as! String
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> AnyObject {
        return[
            "homeTeam":homeTeam, "awayTeam":awayTeam, "sport":sport, "bet":bet, "odds":odds, "company":company, "date":date, "unit":unit, "analys":analys
        ]
    }
    
}