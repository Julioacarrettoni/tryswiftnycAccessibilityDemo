//
//  RoundCornerViews.swift
//  demo
//
//  Created by Julio Carrettoni on 7/23/17.
//  Copyright © 2017 com.devjac. All rights reserved.
//

import UIKit

class RoundCornerViews: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = 6
    }

}
