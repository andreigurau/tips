//
//  ViewController.swift
//  tips
//
//  Created by Andrei Gurau on 12/5/15.
//  Copyright © 2015 Andrei Gurau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    var tipPercentages = [0.18,0.20,0.25]
    var defaultIndex: Int!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.billLabel.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "0.00"
        defaultIndex = defaults.integerForKey("myIndex")
        if defaultIndex == nil{
            tipControl.selectedSegmentIndex = 0
                    }
        else
        {
            tipControl.selectedSegmentIndex = defaultIndex
            
        }
        print("method touched")
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        defaultIndex = defaults.integerForKey("myIndex")
        if defaultIndex == nil{
            tipControl.selectedSegmentIndex = 0
            
        }
        else
        {
            tipControl.selectedSegmentIndex = defaultIndex
            
        }
        print("view will appear")
        billLabel.text = getLastBill()
        if billLabel.text != ""
        {
            var billString = billLabel.text! as NSString
            var billAmount = billString.doubleValue
            
            
            var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
            var tip = billAmount * tipPercentage
            var total = tip + billAmount
            
            
            tipLabel.text = "$\(tip)"
            totalLabel.text = "$\(total)"
            tipLabel.text = String(format: "$%.2f", tip )
            totalLabel.text = String(format: "$%.2f", total )
        }
        var isBackgroundWhite = defaults.objectForKey("whiteColor") as! Bool?
        if isBackgroundWhite == nil || isBackgroundWhite == true
        {
            
            self.view.backgroundColor = UIColor.whiteColor()
            defaults.setBool(true, forKey: "whiteColor")
        }
        
        
        
        else if let backgroundColor = defaults.objectForKey("getBackgroundColor") as! CGFloat?
        {
        let newBackgroundColor = UIColor(hue: backgroundColor, saturation: 0.5, brightness: 0.95, alpha: 0.95)
        self.view.backgroundColor = newBackgroundColor
            defaults.setFloat(Float(backgroundColor), forKey: "settingsBackgroundColor")
            defaults.synchronize()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        print("User edited bill")
        var billString = billLabel.text! as NSString
        var billAmount = billString.doubleValue
        
        
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        var total = tip + billAmount
        
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        tipLabel.text = String(format: "$%.2f", tip )
        totalLabel.text = String(format: "$%.2f", total )
        rememberLastBill(billString as String)
        self.totalLabel.alpha = 0
        self.tipLabel.alpha = 0
        animateTotal()

    }
    
    @IBAction func onTap(sender: AnyObject) {
        //view.endEditing(true)
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
    }
    
    func rememberLastBill(billAmount: String)
    {
        let whenBillSaved = NSDate()
        defaults.setObject(whenBillSaved, forKey: "timeKey")
        defaults.setObject(billAmount, forKey: "billKey")
        defaults.synchronize()
        print("saved?")
    }
    func getLastBill() -> String{
        let now = NSDate()
        let whenClosed = defaults.objectForKey("timeKey") as! NSDate?
        print(now)
        print(whenClosed)
        if  whenClosed == nil || now.timeIntervalSinceDate(whenClosed!) > 600
        {
            return "0"
            
            
        }
        else
        {
            let returnedBill = defaults.objectForKey("billKey") as! String
            return returnedBill
        }
        
        
    }
    
    func animateTotal()
    {
        UIView.animateWithDuration(0.5, animations:{
            self.totalLabel.alpha = 1} )
        UIView.animateWithDuration(0.5, animations:{self.tipLabel.alpha = 1})
        
        
        
        
    }
    
    

}

