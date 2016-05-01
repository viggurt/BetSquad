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
    //MARK: Variabler
    let homeTeam: String
    let awayTeam: String
    let sport: String
    let bet: String
    let odds: String
    let company: String
    let date: String
    let unit: Int
    let analys: String
    let betKey: String
    
    //Referens till Firebase
    let ref: Firebase?

    
    init(homeTeam: String, awayTeam: String, sport: String, bet: String, odds: String, company: String, date: String, unit: Int, analys: String){
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
        self.betKey = ""
        
        
    }
    
    //Samlar data till Firebase
    init(snapshot: FDataSnapshot){
        homeTeam = snapshot.value["homeTeam"] as! String
        awayTeam = snapshot.value["awayTeam"] as! String
        sport = snapshot.value["sport"] as! String
        bet = snapshot.value["bet"] as! String
        odds = snapshot.value["odds"] as! String
        company = snapshot.value["company"] as! String
        date = snapshot.value["date"] as! String
        unit = snapshot.value["unit"] as! Int
        analys = snapshot.value["analys"] as! String
        ref = snapshot.ref
        betKey = snapshot.key
        

        
    }
    
    func toAnyObject() -> AnyObject {
        return[
            "homeTeam":homeTeam, "awayTeam":awayTeam, "sport":sport, "bet":bet, "odds":odds, "company":company, "date":date, "unit":unit, "analys":analys, "betKey":betKey
        ]
    }
    
}