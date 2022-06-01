//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Ален Авако on 31.05.2022.
//


import UIKit
import SnapKit

class FavoritePostsViewController: UIViewController {
    private let viewModel: FavoritePostsViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        return tableView
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        spinnerView = UIActivityIndicatorView(style: .large)
        return spinnerView
    }()
    
    init(viewModel: FavoritePostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(spinnerView)
        
        setup()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.send(.viewWillAppear)
    }
    
    private func setup() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinnerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
//                self.hideContent()
                self.spinnerView.startAnimating()
            case .loading:
//                self.hideContent()
                self.spinnerView.startAnimating()
            case .loaded:
                self.spinnerView.stopAnimating()
                self.showContent()
                self.tableView.reloadData()
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 1
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 0
        }
    }
}

extension FavoritePostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(title: viewModel.posts[indexPath.row].author,
                           image: viewModel.posts[indexPath.row].image,
                           description: viewModel.posts[indexPath.row].description,
                           likes: Int(viewModel.posts[indexPath.row].likes),
                           views: Int(viewModel.posts[indexPath.row].views))
        
        return cell
    }
}
