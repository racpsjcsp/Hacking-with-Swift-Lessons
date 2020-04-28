//
//  ViewController.swift
//  Project1 - TUTORIAL APP
//
//  Created by Rafael Plinio on 25/04/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        print(pictures)
        
    }
    
    //dynamic size of the table view rows (pictures.count)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    //populating the rows with the desired content ("Picture"), each at its own row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures.sorted()[indexPath.row]
        return cell
    }
    
    //display the selected item on the next screen
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            //title becomes "picture 3 of 10", etc
            vc.imageTitle = "Picture \(indexPath.row + 1) of \(pictures.count)"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

