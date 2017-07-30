//
//  CheckOutViewController.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class CheckOutViewController: BaseViewController {

    var pizzaSize: Int = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onPlaceOrderButtonTUI(_ sender: Any) {
        SuperPizzaManagerHandlerWrapper.storePizza(pizza: Pizza(size: pizzaSize))
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onCancelOrderButtonTUI(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
