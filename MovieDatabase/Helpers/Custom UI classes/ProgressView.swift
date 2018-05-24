//
//  ProgressView.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import UIKit

class ProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: ProgressView {
        struct Static {
            static let instance: ProgressView = ProgressView()
        }
        return Static.instance
    }
    
    func showProgressView(_ view: UIView, contentOffset: CGPoint?) {
        containerView.frame = view.frame
        if let viewContentOffset = contentOffset {
            containerView.center = CGPoint(x: view.center.x, y: view.center.y + viewContentOffset.y)
        } else {
            containerView.center = view.center
        }
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = view.center
        progressView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
