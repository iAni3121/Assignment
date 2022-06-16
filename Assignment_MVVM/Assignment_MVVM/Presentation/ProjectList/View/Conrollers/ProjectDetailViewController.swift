//
//  ProjectDetailViewController.swift
//  Assignment_MVVM
//
//  Created by Anirudha Kumar on 14/06/22.
//

import UIKit

class ProjectDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var forkImageView: UIImageView!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    lazy var userData = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewData()
        configureImageView()
        configureNavigationView()
    }
    
    func configureImageView() {
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
    }
    
    func configureNavigationView() {
        self.navigationItem.title = userData.name?.capitalized
    }
    
    func setupViewData() {
        if let imageData = userData.getProfileImage(urlString: userData.owner?.avatarUrl ?? ""), let image = UIImage(data:imageData) {
            profileImage.image = image
        }
        userNameLabel.text = userData.owner?.login?.capitalized
        descriptionLabel.text = userData.description
        starCountLabel.text = "\(0) Stars"
        forksCountLabel.text = "\(0) Forks"
        
    }
    

}

