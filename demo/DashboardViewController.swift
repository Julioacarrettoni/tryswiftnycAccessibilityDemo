//
//  DashboardViewController.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController, PizzaViewDelegate {
    
    @IBOutlet weak var pizzaPanel: RoundCornerViews!
    @IBOutlet weak var orderNowButton: DemoButton!
    @IBOutlet weak var orderNowButtonSubtitle: UILabel!
    @IBOutlet weak var pizzaView: PizzaView!
    @IBOutlet weak var portionsLeft: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaView.pizzaDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pizzaView.pizza = SuperPizzaManagerHandlerWrapper.getStoredPizzaBack()
        updateUI()
    }
    
    func updateUI() {
        let pizza = pizzaView.pizza
        if !pizza.isGone {
            updatePortionsLabel()
            pizzaPanel.isHidden = false
            orderNowButton.isHidden = true
            orderNowButtonSubtitle.isHidden = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(DashboardViewController.disposePizza))
        }
        else {
            pizzaPanel.isHidden = true
            orderNowButton.isHidden = false
            orderNowButtonSubtitle.isHidden = false
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DashboardViewController.showActionPicker))
        }
        SuperPizzaManagerHandlerWrapper.storePizza(pizza: pizza)
    }
    
    func updatePortionsLabel() {
        let availablePortions = pizzaView.pizza.portions.reduce(0, {$0 + ($1 ? 1 : 0)})
        portionsLeft.text = "\(availablePortions)/\(pizzaView.pizza.portions.count)"
        if pizzaView.pizza.portions.count / availablePortions >= 4 {
            portionsLeft.textColor = UIColor.red
        }
        else {
            portionsLeft.textColor = UIColor.darkGray
        }
    }
    
    func pizzaStateUpdated(_ pizza: Pizza) {
        updateUI()
        if pizza.isGone {
            showUpsaleAlert()
        }
    }
    
    @objc func disposePizza() {
        pizzaView.disposePizza()
    }
    
    func showUpsaleAlert() {
        let alertController = UIAlertController(title: NSLocalizedString("No More Pizza? 😢", comment: "Upsale alert title"),
                                                message: NSLocalizedString("You could order one NOW and get it in less than 30 minutes! 😄", comment: "Upsale alert body"),
                                                preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: NSLocalizedString("YES!", comment: "Upsale alert confirmation button, is the left one"), style: .default) {[weak self] action in
            self?.performSegue(withIdentifier: "buyPizza", sender: nil)
        }
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Nah", comment: "Upsale alert cancel button, is the roght one"), style: .cancel) {[weak self] action in
            self?.updateUI()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {}
    }
    
    @objc func showActionPicker() {
        let actionSheet = UIAlertController.init(title: "Track a Pizza", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: NSLocalizedString("Buy Pizza", comment:"Option for pop up menu"), style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "buyPizza", sender: nil)
        }))
        actionSheet.addAction(UIAlertAction.init(title: NSLocalizedString("I already have one", comment:"Option for pop up menu"), style: .default, handler: { (action) in
            self.addPizza()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func addPizza() {
        performSegue(withIdentifier: "addPizza", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPizza",
            let detailViewController = segue.destination as? DetailViewController {
            detailViewController.isBuyingPizza = false
        }
    }
}
