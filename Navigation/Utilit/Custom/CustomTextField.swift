//
//  CustomTextField.swift
//  Navigation
//
//  Created by Ален Авако on 20.01.2022.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String, indent: CGFloat, textColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.indent(size: indent)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
