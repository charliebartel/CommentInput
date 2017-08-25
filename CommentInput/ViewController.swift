//
//  ViewController.swift
//  CommentInput
//
//  Created by Charlie Bartel on 8/22/17.
//  Copyright © 2017 TrainingPeaks. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //---------------------------------------------------------------------
    // MARK: - UIViewController methods
    //---------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //---------------------------------------------------------------------
    // MARK: - UITableViewDelegate methods
    //---------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(CommentsViewController(), animated: true)
    }
    
    //---------------------------------------------------------------------
    // MARK: - UITableViewDataSource methods
    //---------------------------------------------------------------------
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Comments"
        return cell
    }
}
