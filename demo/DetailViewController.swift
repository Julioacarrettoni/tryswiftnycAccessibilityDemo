//
//  DetailViewController.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pizzaSizeSelector: UISegmentedControl!
    @IBOutlet weak var continueButton: DemoButton!
    @IBOutlet weak var doneButton: DemoButton!
    
    var isBuyingPizza: Bool = true
    let pizzaOptions = [NSLocalizedString("Mozzarella", comment: "Pizza Option for the pizza piccker"),
                        NSLocalizedString("Pepperoni", comment: "Pizza Option for the pizza piccker"),
                        NSLocalizedString("Meatballs", comment: "Pizza Option for the pizza piccker"),
                        NSLocalizedString("Veggie", comment: "Pizza Option for the pizza piccker"),
                        NSLocalizedString("Garden", comment: "Pizza Option for the pizza piccker"),
                        NSLocalizedString("Pineapple", comment: "Pizza Option for the pizza piccker"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isHidden = isBuyingPizza
        continueButton.isHidden = !isBuyingPizza
    }
    
    func selectedSize() -> Int {
        let selected = pizzaSizeSelector.selectedSegmentIndex
        return selected == 0 ? 4 : selected == 1 ? 6 : 8
    }
    
    @IBAction func onDoneButtonTUI(_ sender: Any) {
        SuperPizzaManagerHandlerWrapper.storePizza(pizza: Pizza(size: selectedSize()))
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkoutPizza",
            let checkOutViewController = segue.destination as? CheckOutViewController {
            checkOutViewController.pizzaSize = selectedSize()
        }
    }
    
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pizzaOptions.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pizzaOptions[row]
    }
}
