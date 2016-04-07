//
//  AddToViewController.swift
//  BetTogether
//
//  Created by Viktor on 02/03/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase

class AddToViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    let ref = Firebase(url: "https://betsquad.firebaseio.com/")
    var unit: Int = 1

    //MARK: Outlets
    @IBOutlet weak var homeTeamTextField: UITextField!
    @IBOutlet weak var awayTeamTextField: UITextField!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var oddsTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var datePickerField: UITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var betText: String = ""
    
    var delegate: ViewController?
    
    //MARK: Pickerview egenskaper
    var dataPickerView = UIPickerView()
    var betType = ["1","X","2", "Över", "Under", "Målskytt","Resultat"]
    var sport = ["Baseball", "Fotboll", "Basket", "Hockey", "Tennis"]
    var activeDataArray = []
    var dataTextField = UITextField()
    
    
    //TextView editing incomming
    //let PLACEHOLDER_TEXT = "Skriv din analys här..."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportTextField.inputView = dataPickerView
        betTextField.inputView = dataPickerView
        dataPickerView.delegate = self
        dataPickerView.dataSource = self
        self.oddsTextField.delegate = self
        self.companyTextField.delegate = self
        self.homeTeamTextField.delegate = self
        self.awayTeamTextField.delegate = self
        reviewText?.delegate = self
        
        //Funktion för att toggla ner tangentbordet när man klickar på bakgrunden
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        datePickerView.addTarget(self, action: Selector("datePickerChanged"), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //Om textfield "sportTextField" eller "betTextField" är klickad så kommer en PickerView upp
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeDataArray = [] //clear out the clicked field data array
        if textField == sportTextField {
            activeDataArray = sport
        } else
            if textField == betTextField {
                activeDataArray = betType
        }
        dataPickerView.reloadAllComponents()
        dataPickerView.hidden = false
    
    }
    
    //MARK: Funktioner för Picker View
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activeDataArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return activeDataArray[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeDataArray == betType {
            betTextField.text = betType[row] as String
        }
        else if activeDataArray == sport {
            sportTextField.text = sport[row] as String
        }
        //Göm pickerviewen
        
        dataPickerView.reloadAllComponents()
        dataPickerView.hidden = true
        self.dismissKeyboard()
        //dataPickerView.reloadAllComponents()
        //self.dataPickerView.resignFirstResponder()
        //self.dataPickerView.frameForAlignmentRect(CGRectMake(0, 900, 375, 219))
        
    }
    
    //function to hide data in
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    //MARK: Actions
    
    
    @IBAction func placeOddsButton(sender: UIButton) {
        let homeTeam = homeTeamTextField.text!
        let awayTeam = awayTeamTextField.text!
        let sportText = sportTextField.text!
        betText = betTextField.text!
        let oddsText = Double(oddsTextField.text!)
        let companyText = companyTextField.text!
        let review = reviewText.text!
        let date = datePickerField.text!
        
        let placedBet = PlacedBet(homeTeam: homeTeam, awayTeam: awayTeam, sport: sportText, bet: betText, odds: oddsText!, company: companyText, date: date, unit: unit, analys: "hej")
        
        let betRef = ref.childByAppendingPath("Placed Bet")
        let betIdRef = betRef.childByAutoId()
        
        betIdRef.setValue(placedBet.toAnyObject())
        
        //delegate?.addGame(homeTeam,awayTeam: awayTeam)
        homeTeamTextField.text = ""
        awayTeamTextField.text = ""
        sportTextField.text = ""
        betTextField.text = ""
        oddsTextField.text = ""
        companyTextField.text = ""
        reviewText.text = ""
    }
    
    @IBAction func unitsSegment(sender: AnyObject) {
        
        switch segmentControl.selectedSegmentIndex{
        case 0:
            unit = 1
            
        case 1:
            unit = 2
        
        case 2:
            unit = 3
            
        case 3:
            unit = 4
            
        case 4:
            unit = 5
            
        default:
            unit = 1
        
        }
        
    }
    
    func datePickerChanged(sender: UIDatePicker){
    
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        //dateFormatter.dateFormat = "dd-mm-yyyy hh:mm"
        datePickerField.text = dateFormatter.stringFromDate(sender.date)
        
        
    }
    
    @IBAction func dateTextFieldPressed(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    
    }
    
    @IBAction func datePickerChangedValue(sender: UIDatePicker) {
        print("hej")
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
