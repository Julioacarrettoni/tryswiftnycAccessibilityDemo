//
//  BaseViewController.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        self.view.backgroundColor = .clear
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "wood.jpg"))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImage, at: 0)
        view.topAnchor.constraint(equalTo: backgroundImage.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: backgroundImage.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor).isActive = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
