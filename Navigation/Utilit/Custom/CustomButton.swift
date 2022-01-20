//
//  CustomButton.swift
//  Navigation
//
//  Created by Ален Авако on 17.01.2022.
//

import UIKit

final class CustomButton: UIButton {
    
    var tapButton: (() -> Void)?
    
    init(color: String, title: String, titleColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        backgroundColor = UIColor(named: color)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        tapButton?()
    }
}
