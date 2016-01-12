//
//  MainScreenViewController.swift
//  Ball Drop
//
//  Created by Xinyu Zhao on 1/3/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextView!
    
    @IBOutlet weak var fireworkPic: UIImageView!
    
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var fireworkPic2: UIImageView!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var colorTimer: NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width/2
        titleLabel.textAlignment = .Center
        titleLabel.center.x = width
        
        errorLabel.hidden = true
        errorLabel.center.x = width
        
        fireworkPic.center.x = width/2 + 5
        self.view.bringSubviewToFront(fireworkPic)
        fireworkPic2.center.x = width/2 * 3 - 5
        self.view.bringSubviewToFront(fireworkPic2)
        
        view.layer.borderColor = UIColor.purpleColor().CGColor
        view.layer.borderWidth = 10.0
        
        label.center.x = width
        yearText.center.x = width
        
        startButton.center.x = width
        colorTimer = NSTimer.scheduledTimerWithTimeInterval(1.0/2.0, target: self, selector: "colorChange", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func colorChange()
    {
        let ranColor = BallDropViewController().randomColor()
        view.layer.borderColor = ranColor.CGColor
    }
    
    
    @IBAction func toBallDrop(sender: UIButton) {
        if(yearText.text?.characters.count > 4 || yearText.text == "")
        {
            errorLabel.hidden = false
        }
        else{
            let destination = self.storyboard?.instantiateViewControllerWithIdentifier("BallDrop") as! BallDropViewController
            destination.year = yearText.text
            self.presentViewController(destination, animated: true, completion: nil)
            errorLabel.hidden = true
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

}
