//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Daniel Eden on 30/08/2014.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class PhotoViewController: ViewController, UIScrollViewDelegate {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoActions: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainPhotoView: UIImageView!
    
    var photo: UIImage!
    var coordinates: CGRect!
    var origin: FeedViewController!
    
    var window = UIApplication.sharedApplication().keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        doneButton.alpha = 0
        photoActions.alpha = 0
        mainPhotoView.alpha = 0
        
        mainPhotoView.image = photo
        
        scrollView.delegate = self
        scrollView.contentSize = window.frame.size
    }
    
    override func viewDidAppear(animated: Bool) {
        doneButton.alpha = 0
        photoActions.alpha = 0
        mainPhotoView.alpha = 1
        
        UIView.animateWithDuration(0.4, animations: {
            self.doneButton.alpha = 1
            self.photoActions.alpha = 1
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        var offset = scrollView.contentOffset.y
        
        mainPhotoView.alpha = 0
        doneButton.alpha = 0
        photoActions.alpha = 0
        // Set up the custom transition
        var destinationVC = origin
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        // Create the transition with a custom duration
        var duration = 0.3
        
        // Create a temporary UIImageView to transition to the lightbox
        var newImageView = UIImageView(image: mainPhotoView.image)
        var height = newImageView.image.size.height / newImageView.image.size.width * 320
        
        var frame = CGRect(x: 0, y: 0, width: 320, height: height)
        
        newImageView.frame = frame
        newImageView.center = mainPhotoView.center
        newImageView.center.y -= offset
        println()
        newImageView.contentMode = UIViewContentMode.ScaleAspectFill
        newImageView.clipsToBounds = true
        
        window.addSubview(newImageView)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            newImageView.frame = self.coordinates
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: {
                    newImageView.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                        newImageView.removeFromSuperview()
                })
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneButtonTouch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        var offset = scrollView.contentOffset.y
        
        // Ensure non-negative numbers
        offset = offset < 0 ? offset * -1 : offset
        
        // Get a fraction of the offset for our background color
        offset = 1 - offset/100
        
        // Set a limit on the background translucency
        var color = offset < 0.4 ? 0.4 : offset
        
        // Set the color
        self.view.backgroundColor = UIColor(white: 0, alpha: color)
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        // Animate the buttons out
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        UIView.animateWithDuration(0.2, animations: {
            self.doneButton.alpha = 0
            self.photoActions.alpha = 0
        })
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        var offset = scrollView.contentOffset.y
        
        // Ensure non-negative numbers
        offset = offset < 0 ? offset * -1 : offset

        // Dismiss if the offset is significant
        if offset > 50 {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // Animate the buttons back in
        UIView.animateWithDuration(0.2, animations: {
            self.doneButton.alpha = 1
            self.photoActions.alpha = 1
        })
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
