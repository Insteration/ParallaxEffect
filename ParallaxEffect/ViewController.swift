//
//  ViewController.swift
//  ParallaxEffect
//
//  Created by Art Karma on 5/21/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let images = [UIImage(named: "001"), UIImage(named: "003"), UIImage(named: "004"), UIImage(named: "005"), UIImage(named: "006"), UIImage(named: "007"), UIImage(named: "008"), UIImage(named: "009")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.layoutIfNeeded()
        setupScrollView()

    }

    private func setupScrollView() {
        scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(images.count)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        
        for (i, image) in images.enumerated() {
            
            let view = ParallaxView()
            
            view.frame = CGRect(x: self.scrollView.frame.width * CGFloat(i), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            view.imageView.image = image
//            view.imageView.contentMode = .center
            view.tag = i + 10
            self.scrollView.addSubview(view)
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    // Add Parallax Effect
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tempo = 200 / scrollView.frame.width
        
        for i in 0..<images.count {
            let parallaxView = scrollView.viewWithTag(i + 10) as! ParallaxView
            let newX: CGFloat = tempo * (scrollView.contentOffset.x - CGFloat(i) * scrollView.frame.width)
            parallaxView.imageView.frame = CGRect(x: newX, y: parallaxView.imageView.frame.origin.y, width: parallaxView.imageView.frame.width, height: parallaxView.imageView.frame.height)
        }
    }
}
