//
//  LogInViewController.swift
//  Facebook
//
//  Created by Daniel Eden on 8/11/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var helpCenterLabel: UILabel!
    var formY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formY = formContainerView.frame.origin.y
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var topMargin = 30
        
        var y = topMargin + Int(formContainerView.frame.size.height) + 20

        signUpLabel.frame = CGRect(x: signUpLabel.frame.origin.x, y: CGFloat(y), width: 0, height: 0)

        
//        signUpLabel.frame = CGRect(x: signUpLabel.frame.origin.x, y: topMargin + formContainerView.frame.size.height + 20, width: signUpLabel.frame.size.width, height: signUpLabel.frame.size.height)
//
//        formContainerView.frame = CGRect(x: formContainerView.frame.origin.x, y: topMargin, width: formContainerView.frame.size.width, height: formContainerView.frame.size.height)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        formContainerView.frame = CGRect(x: formContainerView.frame.origin.x, y: formY, width: formContainerView.frame.size.width, height: formContainerView.frame.size.height)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
