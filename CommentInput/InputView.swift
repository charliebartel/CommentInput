//
//  InputView.swift
//  CommentInput
//
//  Created by Charlie Bartel on 8/22/17.
//  Copyright © 2017 TrainingPeaks. All rights reserved.
//

import Foundation
import UIKit

class InputView : UIView {
    
    public let commentInputAccessory = CommentInputAccessory()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        return commentInputAccessory
    }
}
