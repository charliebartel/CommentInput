//
//  CommentsViewController.swift
//  CommentInput
//
//  Created by Charlie Bartel on 8/22/17.
//  Copyright © 2017 TrainingPeaks. All rights reserved.
//

import Foundation
import UIKit

class CommentsViewController: UITableViewController, CommentInputAccessoryDelegate {
    
    fileprivate var list: [String] = []
    private let newInputView = InputView()
    
    //---------------------------------------------------------------------
    // MARK: - UIViewController methods
    //---------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        tableView.register(CommentCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40.0
        
        view.addSubview(newInputView)
        newInputView.becomeFirstResponder()
        newInputView.commentInputAccessory.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newInputView.commentInputAccessory.textView.becomeFirstResponder()
    }
    
    //---------------------------------------------------------------------
    // MARK: - UITableViewDelegate methods
    //---------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        newInputView.commentInputAccessory.textView.resignFirstResponder()
    }
    
    //---------------------------------------------------------------------
    // MARK: - UITableViewDataSource methods
    //---------------------------------------------------------------------
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CommentCell {
            cell.accessoryType = .none
            cell.commentLabel.text = list[indexPath.row]
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //---------------------------------------------------------------------
    // MARK: - CommentInputAccessoryDelegate methods
    //---------------------------------------------------------------------
    
    func postText(_ text: String) {
        list.append(text)
        tableView.reloadData()
        let path = IndexPath(row: list.count - 1, section: 0)
        tableView.scrollToRow(at: path, at: .bottom, animated: true)
    }
}
