//
//  DetailTransitionManager.swift
//  GrabilityTest
//
//  Created by Ricardo on 4/6/16.
//  Copyright © 2016 ricardo. All rights reserved.
//

import UIKit

class DetailTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    private var presenting = false
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        // assign references to our menu view controller and the 'bottom' view controller from the tuple
        // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let detailViewController = !self.presenting ? screens.from as! DetailViewController : screens.to as! DetailViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let detailView = detailViewController.view
        let bottomView = bottomViewController.view
        
        // prepare menu items to slide in
        if (self.presenting){
            self.offStageMenuController(detailViewController)
        }
        
        // add the both views to our view controller
        container!.addSubview(bottomView)
        container!.addSubview(detailView)
        
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                self.onStageMenuController(detailViewController) // onstage items: slide in
            }
            else {
                self.offStageMenuController(detailViewController) // offstage items: slide out
            }
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })
        
    }
    
    func offStage(amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuController(detailViewController: DetailViewController){
        
        detailViewController.view.alpha = 0
        
        // setup paramaters for 2D transitions for animations
        let topRowOffset  :CGFloat = 200
        let middleRowOffset :CGFloat = 500
        let bottomRowOffset  :CGFloat = 900
        
        detailViewController.image.transform = self.offStage(-topRowOffset)
        detailViewController.name.transform = self.offStage(topRowOffset)
        
        detailViewController.artistLabel.transform = self.offStage(-middleRowOffset)
        detailViewController.artist.transform = self.offStage(middleRowOffset)
        
        detailViewController.priceLabel.transform = self.offStage(-middleRowOffset)
        detailViewController.price.transform = self.offStage(middleRowOffset)
        
        detailViewController.releaseDateLabel.transform = self.offStage(-middleRowOffset)
        detailViewController.releaseDate.transform = self.offStage(middleRowOffset)
        
        detailViewController.rightsLabel.transform = self.offStage(-middleRowOffset)
        detailViewController.rights.transform = self.offStage(middleRowOffset)
        
        detailViewController.summary.transform = self.offStage(-bottomRowOffset)
        
    }
    
    func onStageMenuController(detailViewController: DetailViewController){
        
        // prepare menu to fade in
        detailViewController.view.alpha = 1
        
        detailViewController.image.transform = CGAffineTransformIdentity
        detailViewController.name.transform = CGAffineTransformIdentity
        detailViewController.artistLabel.transform = CGAffineTransformIdentity
        detailViewController.artist.transform = CGAffineTransformIdentity
        detailViewController.priceLabel.transform = CGAffineTransformIdentity
        detailViewController.price.transform = CGAffineTransformIdentity
        detailViewController.releaseDateLabel.transform = CGAffineTransformIdentity
        detailViewController.releaseDate.transform = CGAffineTransformIdentity
        detailViewController.rightsLabel.transform = CGAffineTransformIdentity
        detailViewController.rights.transform = CGAffineTransformIdentity
        detailViewController.summary.transform = CGAffineTransformIdentity
        
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // rememeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
