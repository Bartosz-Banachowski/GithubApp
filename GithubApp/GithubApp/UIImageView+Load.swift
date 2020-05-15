//
//  UIImageView+Load.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 15/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFromURL(url: String?) {
        DispatchQueue.global().async { [weak self] in
            if let url = url {
                let convertToHTTPS: URL?
                if url.contains("https") {
                    convertToHTTPS = URL(string: url)
                } else {
                    convertToHTTPS = URL(string: "https" + url.dropFirst(4))!
                }
                
                if let data = try? Data(contentsOf: convertToHTTPS!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
