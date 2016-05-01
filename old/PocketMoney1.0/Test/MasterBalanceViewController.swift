//
//  MasterBalanceViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-02-24.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit

class MasterBalanceViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    
    @IBAction func pageControlDidPage(sender: AnyObject) {
        let xOffset = scrollView.bounds.width * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPointMake(xOffset,0) , animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        // Creates an instance of BalanceSummaryViewController from nib
        let viewController0 = UIViewController(nibName: "BalanceSummaryViewController", bundle: nil)

        // Adds childView to the viewController
        self.addChildViewController(viewController0)
        // Adds view to scroll view
        self.scrollView.addSubview(viewController0.view)
        viewController0.didMoveToParentViewController(self)
        
        // Creates an instance of IOUSummaryViewController from nib
        let viewController1 = UIViewController(nibName: "IOUSummaryViewController", bundle: nil)
        
        // creates frame for viewController1
        var frame1 = viewController1.view.frame
        // sets the frame's origin x to the width of the frame
        frame1.origin.x = self.view.frame.size.width
        viewController1.view.frame = frame1
        
        // Adds childView to the viewController
        self.addChildViewController(viewController1)
        // Adds view to scroll view
        self.scrollView.addSubview(viewController1.view)
        viewController1.didMoveToParentViewController(self)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0)        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    
}
