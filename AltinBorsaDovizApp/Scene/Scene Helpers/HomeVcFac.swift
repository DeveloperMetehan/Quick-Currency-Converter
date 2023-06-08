//
//  HomeVcFac.swift
//  AltinBorsaDovizApp
//
//  Created by Metehan Karadeniz on 8.06.2023.
//

import UIKit
func setCustomTextField() -> UITextField {
    let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = .center
   
        textField.layer.borderColor = UIColor(hex: "13161c").cgColor
        textField.layer.borderWidth = 3.0
        textField.layer.cornerRadius = 8.0

    return textField
}
    func setCalculateButton() -> UIButton {
    let theBttn = UIButton()
        theBttn.translatesAutoresizingMaskIntoConstraints = false
        theBttn.backgroundColor = .clear
        theBttn.setTitle("Calculate", for: .normal)
        theBttn.backgroundColor = UIColor(hex: "b82c35")
        theBttn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        theBttn.layer.cornerRadius = 10.0
    return theBttn
}
func setCustomLabel() -> UILabel {
    let theLabel = UILabel()
        theLabel.translatesAutoresizingMaskIntoConstraints = false
    return theLabel
}
