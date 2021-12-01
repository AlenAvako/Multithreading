//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ален Авако on 10.09.2021.
//  Created by Ален Авако on 09.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        title = "Profile"
        
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private lazy var postTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.toAutoLayout()
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        postTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
        postTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        postTableView.separatorInset = .zero
        return postTableView
    }()
    
    func setupTableView() {
        view.addSubview(postTableView)
        postTableView.contentInsetAdjustmentBehavior = .scrollableAxes
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return arrayOfPosts.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            
            let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
            cell.configureCell(title: arrayOfPosts[indexPath.row].author,
                               image: arrayOfPosts[indexPath.row].image,
                               description: arrayOfPosts[indexPath.row].description,
                               likes: arrayOfPosts[indexPath.row].likes,
                               views: arrayOfPosts[indexPath.row].views)
            return cell
        } else {
            let cell = postTableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as! PhotosTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.id) as! ProfileHeaderView
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else  {
            return 0
        }
    }
}



extension ProfileViewController: PhotosTableViewCellDelegate {
    func didSelectButton() {
        let photoVC = PhotosViewController()
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
