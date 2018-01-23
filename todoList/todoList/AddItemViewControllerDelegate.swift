//
//  AddItemViewControllerDelegate.swift
//  todoList
//
//  Created by user on 1/22/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    
    func addItem(title: String, details: String, date: Date)
}
