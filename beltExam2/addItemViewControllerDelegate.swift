//
//  addItemViewControllerDelegate.swift
//  beltExam2
//
//  Created by Ricardo Rojas on 11/19/17.
//  Copyright © 2017 Ricardo Rojas. All rights reserved.
//

import UIKit

protocol addItemViewControllerDelegate: class {
    func itemSaved(by controller: UIViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: UIViewController)
}
