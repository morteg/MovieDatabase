//
//  Extensions.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String
extension String {
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showAlert(title: String, message: String, showCancelButton: Bool = false, isDestructive: Bool = false, action: (()->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: isDestructive ?.destructive: .default, handler: {_ in if let action = action{action()}})
        alert.addAction(okAction)
        if showCancelButton {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Realm
extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
