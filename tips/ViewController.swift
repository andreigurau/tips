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
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        print("User edited bill")
        var billAmount = NSString(string: billLabel.text!).doubleValue
        
        
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        var total = tip + billAmount
        
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        tipLabel.text = String(format: "$%.2f", tip )
        totalLabel.text = String(format: "$%.2f", total )
        

    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
        
    }
    
    

}

