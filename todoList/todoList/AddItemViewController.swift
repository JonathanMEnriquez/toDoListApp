//
//  AddItemViewController.swift
//  todoList
//
//  Created by user on 1/22/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var detailsTextField: UITextView!
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        if titleTextField.text != "" && detailsTextField.text != "" {
            
            delegate?.addItem(title: titleTextField.text!, details: detailsTextField.text, date: datePicker.date)
            print("add button pressed")
        }
        else {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
