//
//  ViewController.swift
//  Ball-Drop
//
//  Created by Xinyu Zhao on 12/31/15.
//  Copyright © 2015 Xinyu Zhao. All rights reserved.
//

import UIKit

class BallDropViewController: UIViewController {
    
    var year: String!
    
    @IBOutlet weak var poleView: UIImageView!
    @IBOutlet weak var ballView: UIImageView!
    var ballY: CGFloat!
    
    @IBOutlet weak var yearText: UITextView!
    @IBOutlet weak var newYearText: UITextView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var time: UILabel!
    
    var timer: NSTimer?
    var colorTimer: NSTimer?
    var numberTimer: NSTimer?
    var first = 1;
    
    var originalSize: CGFloat = 50.0
    
    @IBOutlet weak var instructionsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let city = UIImageView(image: UIImage(named: "city"))
        city.frame.size.height = self.view.frame.height
        city.frame.size.width = self.view.frame.width
        self.view.addSubview(city)
        self.view.sendSubviewToBack(city)
        
        instructionsLabel.center = view.center
        
        poleView.center.x = view.frame.width/2 + 12
        ballView.center.x = view.frame.width/2
        
        newYearText.hidden = true
        newYearText.backgroundColor = UIColor.clearColor()
        newYearText.center.x = view.frame.width/2
        newYearText.center.y = poleView.center.y
        newYearText.textAlignment = .Center
        
        yearText.backgroundColor = UIColor.clearColor()
        yearText.text = "IT'S \(year)!!!!"
        yearText.hidden = true
        yearText.textAlignment = .Center
        yearText.center.x = newYearText.center.x
        yearText.center.y = view.frame.height - yearText.frame.height - 40

        time.center.y = poleView.center.y + poleView.frame.height/2.0 + time.frame.height/2 + 25
        time.center.x = self.view.frame.width/2.0
        time.textAlignment = .Center
        time.textColor = UIColor.cyanColor()
        time.font = UIFont(name: time.font.fontName, size: originalSize)
        
        ballY = ballView.center.y
        
        resetButton.center.x = resetButton.frame.width/2 + 5
        resetButton.center.y = self.view.frame.height - resetButton.frame.height/2
        
        backButton.center.x = backButton.frame.width/2 + 5
        backButton.center.y = backButton.frame.height/2 + 10
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(view)
        if(self.view.frame.contains(location) && !resetButton.frame.contains(location) && first == 1)
        {
            instructionsLabel.hidden = true
            let distance = poleView.frame.height - ballView.center.y
            let time = NSTimeInterval(10.0/distance)
            timer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: "ballDrop", userInfo: nil, repeats: true)
            numberTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
            first++
        }
    }
    
    func countDown()
    {
        var num = Int(time.text!)
        if(num <= 0)
        {
            numberTimer?.invalidate()
            originalSize = 65.0
        }
        else{
            num = num! - 1
            time.text = String(num!)
            originalSize = originalSize + 10
            time.font = UIFont(name: time.font.fontName, size: originalSize)
        }
    }
    
    func ballDrop()
    {
        if(ballView.center.y < (poleView.center.y + (poleView.frame.height/2.0)))
        {
            ballView.center.y = ballView.center.y + 1
        }
        else
        {
            newYearText.hidden = false
            yearText.hidden = false
            time.hidden = true
            colorTimer = NSTimer.scheduledTimerWithTimeInterval(1.0/20.0, target: self, selector: "colorChange", userInfo: nil, repeats: true)
            timer?.invalidate()
        }
    }
    
    func colorChange()
    {
        let ranColor = randomColor()
        newYearText.textColor = ranColor
        yearText.textColor = ranColor
    }
    
    
    func randomColor() -> UIColor
    {
        let r = CGFloat(drand48())
        let g = CGFloat(drand48())
        let b = CGFloat(drand48())
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func reset(sender: AnyObject) {
        first = 1
        
        ballView.center.y = ballY
        
        instructionsLabel.hidden = false
        
        newYearText.hidden = true
        newYearText.backgroundColor = UIColor.clearColor()
        newYearText.center.x = view.frame.width/2
        newYearText.center.y = poleView.center.y
        newYearText.textAlignment = .Center
        
        yearText.backgroundColor = UIColor.clearColor()
        yearText.hidden = true
        yearText.textAlignment = .Center
        yearText.center.x = newYearText.center.x
        yearText.center.y = view.frame.height - yearText.frame.height - 20
        
        time.center.y = poleView.center.y + poleView.frame.height/2.0 + time.frame.height/2 + 25
        time.center.x = self.view.frame.width/2.0
        time.textAlignment = .Center
        time.textColor = UIColor.cyanColor()
        time.hidden = false
        time.font = UIFont(name: time.font.fontName, size: 65.0)
        timer?.invalidate()
        numberTimer?.invalidate()
        time.text! = "10"
    }
}

