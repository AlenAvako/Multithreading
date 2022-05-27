//
//  CitizensTableView.swift
//  Navigation
//
//  Created by Ален Авако on 20.04.2022.
//

import UIKit

class CitizensTableView: UIView {
    
    lazy var citizensTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.backgroundColor = .white
        return tableView
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(citizensTableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        citizensTableView.frame = self.frame
        citizensTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
