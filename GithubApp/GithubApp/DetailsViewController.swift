//
//  DetailsViewController.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 11/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var avatarImgView: UIImageView!
    var userDetails: User?
    
    override func viewDidLoad() {
        avatarImgView.loadFromURL(url: userDetails?.imgURL)
    }
}
