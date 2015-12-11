//
//  SettingsViewController.swift
//  tips
//
//  Created by Andrei Gurau on 12/6/15.
//  Copyright © 2015 Andrei Gurau. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var BrightnessSlider: UISlider!
    @IBOutlet weak var defaultValueControl: UISegmentedControl!
    var index = 0
    var isWhite = false
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let receivedIndex = defaults.integerForKey("myIndex")
        defaultValueControl.selectedSegmentIndex = receivedIndex
        var isBackgroundWhite = defaults.objectForKey("whiteColor") as! Bool?
        if isBackgroundWhite == nil || isBackgroundWhite == true
        {
            
            self.view.backgroundColor = UIColor.whiteColor()
            
        }
        
        
        else if let backgroundColor = defaults.objectForKey("settingsBackgroundColor") as! CGFloat?
        {
            let newBackgroundColor = UIColor(hue: backgroundColor, saturation: 0.5, brightness: 0.95, alpha: 0.95)
            self.view.backgroundColor = newBackgroundColor
            BrightnessSlider.value = Float(backgroundColor)
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        index = defaultValueControl.selectedSegmentIndex
        defaults.setInteger(index, forKey: "myIndex")
        defaults.synchronize()
        print("synchronized")
       
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    
    @IBAction func OnSliderChanged(sender: UISlider) {
        isWhite = false
        var backgroundColor:UIColor
        var sliderValue = CGFloat(sender.value)
        backgroundColor = UIColor(hue: sliderValue, saturation: 0.5, brightness: 0.95, alpha: 0.95)
        self.view.backgroundColor = backgroundColor
        print("slider changed")
        defaults.setFloat(Float(sliderValue), forKey: "getBackgroundColor")
        defaults.setBool(isWhite, forKey: "whiteColor")
        defaults.synchronize()
    }
    
   
    @IBAction func ResetColor(sender: AnyObject) {
        self.view.backgroundColor = UIColor.whiteColor()
        isWhite = true
        defaults.setBool(isWhite, forKey: "whiteColor")
        defaults.synchronize()
    }
    }
    
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


