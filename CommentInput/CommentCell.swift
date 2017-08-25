//
//  CommentCell.swift
//  CommentInput
//
//  Created by Charlie Bartel on 8/24/17.
//  Copyright © 2017 TrainingPeaks. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    
    private static let offset = CGFloat(10)
    private static let font = UIFont.systemFont(ofSize: 20)
    
    private var didUpdateConstraints = false
    let commentLabel = UILabel()
    
    //---------------------------------------------------------------------
    // MARK: - Init methods
    //---------------------------------------------------------------------
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------------------------------------------------------
    // MARK: - UIView methods
    //---------------------------------------------------------------------
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CommentCell.offset).isActive = true
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CommentCell.offset).isActive = true
            commentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CommentCell.offset).isActive = true
            commentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CommentCell.offset).isActive = true
            
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    //---------------------------------------------------------------------
    // MARK: - Private methods
    //---------------------------------------------------------------------
    private func setupViews() {
        selectionStyle = .none
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.numberOfLines = 0
        commentLabel.font = CommentCell.font
        contentView.addSubview(commentLabel)
    }
}
