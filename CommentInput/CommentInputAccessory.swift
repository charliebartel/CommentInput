//
//  CommentInputAccessory
//  CommentInput
//
//  Created by Charlie Bartel on 8/22/17.
//  Copyright © 2017 TrainingPeaks. All rights reserved.
//

import Foundation
import UIKit

protocol CommentInputAccessoryDelegate: class {
    func postText(_ text: String)
}

class CommentInputAccessory: UIView {
    
    weak var delegate: CommentInputAccessoryDelegate?
    public let textView = UITextView()
    
    private static let numberOfLines = CGFloat(3)
    private static let textViewPadding = CGFloat(16)
    private static let textViewfont = UIFont.systemFont(ofSize: 20)
    private static let postFont = UIFont.boldSystemFont(ofSize: 20)
    private static let placeHolderLeftOffset = CGFloat(4)
    private static let placeHolderTopOffset = CGFloat(8)
    private static let postOffset = CGFloat(8)
    
    private var heightConstraint: NSLayoutConstraint?
    private let placeHolderLabel = UILabel()
    private let postLabel = UILabel()
    
    //---------------------------------------------------------------------
    // MARK: - Init methods
    //---------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------------------------------------------------------
    // MARK: - Setup methods
    //---------------------------------------------------------------------
    
    func setup() {
        isUserInteractionEnabled = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = .white
        
        textView.delegate = self
        textView.bounces = true
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.font = CommentInputAccessory.textViewfont
        addSubview(textView)
        
        placeHolderLabel.font = CommentInputAccessory.textViewfont
        placeHolderLabel.textColor = .lightGray
        placeHolderLabel.numberOfLines = 1
        placeHolderLabel.text = "Add a comment..."
        textView.addSubview(placeHolderLabel)
        
        postLabel.font = CommentInputAccessory.postFont
        postLabel.textColor = .lightGray
        postLabel.numberOfLines = 1
        postLabel.text = "Post"
        postLabel.isUserInteractionEnabled = false
        postLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postTap)))
        addSubview(postLabel)

        setupConstraints()
        
        textViewDidChange(textView)
    }
    
    func setupConstraints() {
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: CommentInputAccessory.placeHolderTopOffset).isActive = true
        placeHolderLabel.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: CommentInputAccessory.placeHolderLeftOffset).isActive = true
        placeHolderLabel.rightAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postLabel.leftAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        postLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -CommentInputAccessory.postOffset).isActive = true
        postLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CommentInputAccessory.postOffset).isActive = true
        postLabel.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
    }
    
    //---------------------------------------------------------------------
    // MARK: - Action methods
    //---------------------------------------------------------------------
    
    @objc func postTap() {
        if let delegate = delegate,
            let text = textView.text {
            delegate.postText(text)
            textView.text = .none
            update(textView)
        }
    }
    
    //---------------------------------------------------------------------
    // MARK: - Update methods
    //---------------------------------------------------------------------
    
    func update(_ textView: UITextView) {
        let newHeight = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: .greatestFiniteMagnitude)).height
        let maxHeight = CommentInputAccessory.numberOfLines * CommentInputAccessory.textViewfont.lineHeight.rounded(.toNearestOrAwayFromZero) + CommentInputAccessory.textViewPadding
        if newHeight > maxHeight {
            frame.size.height = maxHeight
            textView.isScrollEnabled = true
        } else {
            frame.size.height = newHeight
            textView.isScrollEnabled = false
        }
        
        if let heightConstraint = heightConstraint {
            heightConstraint.constant = frame.size.height
        }
        
        let hasText = textView.text.characters.count > 0
        placeHolderLabel.isHidden = hasText
        postLabel.textColor = hasText ? .blue : .lightGray
        postLabel.isUserInteractionEnabled = hasText
        
        textView.reloadInputViews()
    }
    
    //---------------------------------------------------------------------
    // MARK: - UIView methods
    //---------------------------------------------------------------------
    
    override func addConstraint(_ constraint: NSLayoutConstraint) {
        heightConstraint = constraint
        super.addConstraint(constraint)
    }
}

//---------------------------------------------------------------------
// MARK: - UITextViewDelegate methods
//---------------------------------------------------------------------

extension CommentInputAccessory: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        update(textView)
    }
}
