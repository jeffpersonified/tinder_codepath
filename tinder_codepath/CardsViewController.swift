//
//  CardsViewController.swift
//  tinder_codepath
//
//  Created by Jeff Smith on 6/3/15.
//  Copyright (c) 2015 Jeff Smith. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var ryanImageView: UIImageView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var cardInitialCenter: CGPoint!
    var initialRotation: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Hey, girl.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as! ProfileViewController
        
        destinationViewController.ryanImage = self.ryanImageView.image
        
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    func CGAffineTransformMakeDegreeRotation(rotation: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeRotation(rotation * CGFloat(M_PI / 180))
    }
    
    @IBAction func didTapRyan(sender: AnyObject) {
        performSegueWithIdentifier("ryanSegue", sender: nil)
    }

    @IBAction func didPan(sender: AnyObject) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            cardInitialCenter = ryanImageView.center
            initialRotation = 0

        } else if sender.state == UIGestureRecognizerState.Changed {
            var rotation = Float(0)
            
            if point.y < (568 / 2) {
                rotation = convertValue(Float(translation.x), r1Min: 0, r1Max: 160, r2Min: Float(initialRotation), r2Max: 50)
            } else {
                rotation = convertValue(Float(-translation.x), r1Min: 0, r1Max: 160, r2Min: Float(initialRotation), r2Max: 50)
            }

            ryanImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y + translation.y)
            ryanImageView.transform = CGAffineTransformMakeDegreeRotation(CGFloat(rotation))
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if translation.x < -50 {
                UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.ryanImageView.center.x = -250
                }, completion: nil)
                bringBackRyan()
            } else if translation.x > 50 {
                UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.ryanImageView.center.x += 250
                }, completion: nil)
                bringBackRyan()
            } else if translation.x > -50 && translation.x < 0 {
                resetToCenter()
            } else if translation.x < 50 && translation.x > 0 {
                resetToCenter()
            }
        }
    }
    
    func bringBackRyan() {
        delay(0.75){
            self.ryanImageView.center = self.cardInitialCenter
            self.ryanImageView.transform = self.CGAffineTransformMakeDegreeRotation(CGFloat(0))
        }
    }
    
    func resetToCenter() {
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.ryanImageView.center = self.cardInitialCenter
            self.ryanImageView.transform = self.CGAffineTransformMakeDegreeRotation(CGFloat(0))
        }, completion: nil)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
