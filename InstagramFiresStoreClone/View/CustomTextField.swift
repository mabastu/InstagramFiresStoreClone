//
//  CustomTextField.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/8/22.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        rightView = spacer
        rightViewMode = .always
        
        borderStyle = .none
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        layer.cornerRadius = 5
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
