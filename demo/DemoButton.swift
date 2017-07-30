//
//  DemoButton.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class DemoButton: UIButton {
    
    var initialTitleColor: UIColor!
    var initialButtonColor: UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialTitleColor = titleLabel?.textColor
        initialButtonColor = backgroundColor
        layer.masksToBounds = true
        layer.cornerRadius = 6
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.6
                backgroundColor = initialTitleColor
                titleLabel?.textColor = initialButtonColor
                setTitleColor(initialButtonColor, for: .normal)
            }
            else {
                alpha = 1.0
                backgroundColor = initialButtonColor
                setTitleColor(initialTitleColor, for: .normal)
            }
        }
    }
    
}
