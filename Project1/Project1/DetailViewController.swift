//
//  DetailViewController.swift
//  Project1 - TUTORIAL APP
//
//  Created by Rafael Plinio on 25/04/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    //var to use to change the title of the selected picture inside the detail screen
    //it is used at ViewController.swift at didSelectRowAt
    var imageTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting the title of the image to "picture 3 of 10"
        title = imageTitle        
        
        //title always small showing the content
        //previous screen will still show large title
        navigationItem.largeTitleDisplayMode = .never
        
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    //hides top bar on tap
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    //shows top bar on tap
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
