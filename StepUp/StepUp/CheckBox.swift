//
//  CheckBox.swift
//  StepUp
//
//  Created by user173542 on 6/18/20.
//  Copyright © 2020 Elana Hummel. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "icons8-unchecked-checkbox-24")! as UIImage
    let uncheckedImage = UIImage(named: "icons8-unchecked-checkbox-50")! as UIImage

    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
