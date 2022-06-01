//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ален Авако on 10.09.2021.
//  Created by Ален Авако on 09.09.2021.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    let user: UserService
    var myUser: User?
    
    private let coreDataService = CoreDataService()
    
    init(user: UserService, name: String) {
        self.user = user
        self.myUser = user.checkUser(name)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        title = "Profile"
        
        setupTableView()
        setupConstraints()
        
        #if DEBUG
        view.backgroundColor = .yellow
        #endif
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutTapped))
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
    
    private func setupTableView() {
        view.addSubview(postTableView)
        postTableView.contentInsetAdjustmentBehavior = .scrollableAxes
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func signOutTapped() {

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
            
            cell.postImage.tag = indexPath.row
            let processor = ImageProcessor()
            
            for (i, _) in arrayOfPosts.enumerated() {
                if cell.postImage.tag == i {
                    if i == 0 {
                        processor.processImage(sourceImage: cell.postImage.image!, filter: .tonal) { image in
                            cell.postImage.image = image
                        }
                    } else if i == 1 {
                        processor.processImage(sourceImage: cell.postImage.image!, filter: .bloom(intensity: 10)) { image in
                            cell.postImage.image = image
                        }
                    } else if i == 2 {
                        processor.processImage(sourceImage: cell.postImage.image!, filter: .crystallize(radius: 10)) { image in
                            cell.postImage.image = image
                        }
                    }
                }
            }
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
            headerView.nameLabel.text = myUser?.name
            headerView.profileImage.image = UIImage(named: myUser?.avatar ?? "Ava")
            headerView.statusLabel.text = myUser?.status
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(savePostCoreData(_:)))
            doubleTap.numberOfTapsRequired = 2
            postTableView.addGestureRecognizer(doubleTap)
        }
    }
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func didSelectButton() {
        let photoVC = PhotosViewController()
        navigationController?.pushViewController(photoVC, animated: true)
    }
    
    @objc func savePostCoreData(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let touchLocation: CGPoint = sender.location(in: sender.view)
            guard let indexPath: IndexPath = postTableView.indexPathForRow(at: touchLocation) else { return }
            let post = arrayOfPosts[indexPath.row]
            coreDataService.addFavoritePost(post: post)
            print(post)
        }
    }
}
