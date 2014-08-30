//
//  FeedDetailViewController.swift
//  Facebook
//
//  Created by Daniel Eden on 8/6/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class FeedDetailViewController: ViewController {

    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBackButtonTouch(sender: AnyObject) {
        navigationController.popViewControllerAnimated(true);
    }
    
    @IBAction func onLikeButtonTouch(sender: AnyObject) {
        if(likeButton.selected) {
            likeButton.selected = false
        } else {
            likeButton.selected = true
        }
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
