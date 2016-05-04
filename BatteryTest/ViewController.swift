//
//  ViewController.swift
//  BatteryTest
//
//  Created by Pravin Sankeshwari on 04/05/16.
//  Copyright © 2016 Pravin Sankeshwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer : NSTimer!
    var isDischarging : Bool!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    //MARK:  View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isDischarging = false
        self.upperView.backgroundColor = UIColor.greenColor()
        self.upperView.layer.borderWidth = 1
        self.upperView.layer.borderColor = UIColor.blackColor().CGColor
    }

    
    //MARK: Memory Management

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Button Actions
    
    @IBAction func dischargeAction(sender: AnyObject) {
        if !isDischarging{
            isDischarging = true
            self.resetTimer()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "update", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func chargeAction(sender: AnyObject) {
        if isDischarging!{
            isDischarging = false
            self.resetTimer()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "update", userInfo: nil, repeats: true)
        }
    }
    

    //MARK: Update the battery percentage
    
    func update() {
        var frame : CGRect = self.bottomView.frame
        if isDischarging!
        {
            frame.size.height = frame.size.height + 1
        }
        else
        {
            frame.size.height = frame.size.height - 1
            
        }
        self.bottomView.frame = frame
        print("\(self.bottomView.frame.height)" + " " + "\(self.upperView.frame.height)")
        
        if (self.bottomView.frame.size.height == self.upperView.frame.size.height) || self.bottomView.frame.size.height == 0
        {
            self.resetTimer()
        }
        else if self.bottomView.frame.size.height > self.upperView.frame.size.height*0.90
        {
            self.upperView.backgroundColor = UIColor.redColor()
        }
        else if self.bottomView.frame.size.height > self.upperView.frame.size.height*0.75
        {
            self.upperView.backgroundColor = UIColor.orangeColor()
        }
        else
        {
            self.upperView.backgroundColor = UIColor.greenColor()
        }
        
        let val = (self.bottomView.frame.size.height/2.08)
        print(100 - NSInteger(val))
        
        self.percentageLabel.text = String(100 - NSInteger(val)) + "%"
    }
    

    //MARK: Reset Timer
    
    func resetTimer(){
        if timer != nil{
            timer.invalidate()
            timer = nil
        }
        
    }
    
}

