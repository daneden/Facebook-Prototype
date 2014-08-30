//
//  FeedViewController.swift
//  Facebook
//
//  Created by Daniel Eden on 8/6/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class FeedViewController: ViewController {

    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var tapTarget: UIImageView!
    var transition: PhotoSegue!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Dynamically set the size of the scroll area
        feedScrollView.contentSize = feedImageView.frame.size
        
        feedScrollView.contentInset.top = 0
        feedScrollView.contentInset.bottom = 50
        feedScrollView.scrollIndicatorInsets.top = 0
        feedScrollView.scrollIndicatorInsets.bottom = 50
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPhotoTap(gesture: UITapGestureRecognizer) {
        tapTarget = gesture.view as UIImageView
        performSegueWithIdentifier("photoViewSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "photoViewSegue" {
            // Set up the custom transition
            var destinationVC = segue.destinationViewController as PhotoViewController
            var window = UIApplication.sharedApplication().keyWindow
            var frame = window.convertRect(tapTarget.frame, fromView: self.feedScrollView)
            
            destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            
            // Pass the image to the lightbox
            destinationVC.photo = tapTarget.image
            destinationVC.coordinates = frame
            destinationVC.origin = self
            
            // Create the transition with a custom duration
            var duration = 0.3
            
            transition = PhotoSegue()
            transition.duration = duration
            
            // Create a temporary UIImageView to transition to the lightbox
            var newImageView = UIImageView(image: tapTarget.image)
            newImageView.frame = frame
            newImageView.contentMode = UIViewContentMode.ScaleAspectFill
            newImageView.clipsToBounds = true

            var imageSize = newImageView.image.size
            var newHeight = imageSize.height / imageSize.width * 320
            
            window.addSubview(newImageView)
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                newImageView.frame = CGRect(x: 0, y: 44, width: 320, height: newHeight)
                newImageView.center = window.center
                }) { (finished: Bool) -> Void in
                    UIView.animateWithDuration(0.1, animations: {
                        newImageView.alpha = 0
                        }, completion: { (finished: Bool) -> Void in
                            newImageView.removeFromSuperview()
                    })
            }
            
            destinationVC.transitioningDelegate = transition
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
