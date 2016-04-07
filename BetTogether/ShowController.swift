//
//  ShowController.swift
//  BetTogether
//
//  Created by Viktor on 08/03/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ShowController: UIViewController {
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var betTypeLabel: UILabel!
    
    var teams: String?
    var betType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamLabel.text = teams
        betTypeLabel.text = betType
        
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
