//
//  Pizza.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class SuperPizzaManagerHandlerWrapper {
    static let portionsKey = "portions_key"
    static func storePizza(pizza: Pizza) {
        UserDefaults.standard.set(pizza.portions, forKey: portionsKey)
    }
    
    static func getStoredPizzaBack() -> Pizza {
        if let portions = UserDefaults.standard.object(forKey: portionsKey) as? [Bool] {
            return Pizza(portions: portions)
        }
        else {
            return Pizza(portions: [false])
        }
    }
}

struct Pizza: Codable {
    var portions: [Bool] = []
    var isGone: Bool {
        return !portions.reduce(false, { $0 || $1 })
    }
    
    init(portions: [Bool]) {
        self.portions = portions
    }
    
    init(size: Int) {
        portions = Array(0..<size).map({_ in true })
    }
}

protocol PizzaViewDelegate {
    func pizzaStateUpdated(_ pizza: Pizza)
}

class PizzaView: UIView {
    var pizzaDelegate: PizzaViewDelegate?
    
    var pizza: Pizza = Pizza(portions: [false, true, true, true, false , false, true, true]) {
        didSet {
            refreshUI()
        }
    }
    
    func disposePizza() {
        pizza.portions = pizza.portions.map({ _ in false })
        refreshUI()
    }
    
    //Pizza colors from:
    //http://www.colourlovers.com/color/FFFBD3/pizza_crust
    //http://www.colourlovers.com/color/BB2A0F/pizza_sauce
    //http://www.colourlovers.com/color/F5ECB7/mountain_cheese
    let doughtColor = "E4B987".hexColor.cgColor
    let sauceColor = "BB2A0F".hexColor.cgColor
    let cheeseColor = "FAF6C8".hexColor.cgColor
    let lineColor = "D0CDAC".hexColor.cgColor
    
    var stepAngle:CGFloat { return abs(CGFloat.pi*2.0)/CGFloat(pizza.portions.count)  }

    func pathForPortion(_ portion:Int) -> CGPath {
        return pathForPortion(portion, withRadious: self.radius)
    }
    
    func pathForPortion(_ portion:Int, withRadious radious:CGFloat) -> CGPath {
        return pathForPortion(portion, withRadious: radious, andStepAngle:self.stepAngle)
    }
    
    var drawingTransform: CGAffineTransform {
        let scaleY: CGFloat = self.bounds.height / self.frame.size.width
        return CGAffineTransform(scaleX: 1.0, y: scaleY)
    }
    
    func pathForPortion(_ portion:Int, withRadious radious:CGFloat, andStepAngle stepAngle:CGFloat) -> CGPath {
        let step =  stepAngle
        let transform = drawingTransform
        
        let path = CGMutablePath()
        path.move(to: pCenter, transform: transform)
        let angle = step*CGFloat(portion) - CGFloat.pi/2.0 - step/2.0
        path.addRelativeArc(center: pCenter, radius: radious, startAngle: angle, delta:step, transform: transform)
        path.addLine(to: pCenter, transform: transform)
        return path
    }
    
    var radius: CGFloat {
        return (self.frame.size.width/2.0) - 2.0
    }
    
    var pCenter: CGPoint {
        return CGPoint(x:self.bounds.width/2.0, y:self.bounds.width/2.0)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(doughtColor)
        context.setStrokeColor(lineColor)
        for i in 0..<pizza.portions.count {
            if pizza.portions[i] {
                context.addPath(pathForPortion(i, withRadious: radius))
                context.drawPath(using: .fillStroke)
            }
        }
        
        context.setFillColor(sauceColor)
        for i in 0..<pizza.portions.count {
            if pizza.portions[i] {
                context.addPath(pathForPortion(i, withRadious: radius*0.85))
                context.fillPath()
            }
        }
        
        context.setFillColor(cheeseColor)
        for i in 0..<pizza.portions.count {
            if pizza.portions[i] {
                context.addPath(pathForPortion(i, withRadious: radius*0.75))
                context.fillPath()
            }
        }
    }
    
    func getPortionIDFor(point: CGPoint) -> Int {
        for i in 0..<pizza.portions.count {
            if pathForPortion(i).contains(point) {
                return i
            }
        }
        return -1
    }
    
    func refreshUI() {
        self.setNeedsDisplay()
        self.pizzaDelegate?.pizzaStateUpdated(self.pizza)
    }
    
    //Mark - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let currentTouch = touches.first as UITouch? else {
            return
        }
        let touchPoint = currentTouch.location(in: self)
        let portionId = self.getPortionIDFor(point: touchPoint)
        if portionId >= 0 && portionId < self.pizza.portions.count {
            if self.pizza.portions[portionId] {
                self.pizza.portions[portionId] = false
                refreshUI()
            }
        }
    }
}

//String extension by blixt (https://gist.github.com/blixt) from https://gist.github.com/arshad/de147c42d7b3063ef7bc#gistcomment-1585208
extension String {
    var hexColor: UIColor {
        let hex = self.trimmingCharacters(in:NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
