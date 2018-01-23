//
//  TodoTableViewController.swift
//  todoList
//
//  Created by user on 1/22/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController, AddItemViewControllerDelegate {

    //variables
    var items = [TodoItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItems()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddItemViewController
        destination.delegate = self
    }
    
    // MARK: setting Table
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! TodoTableViewCell
        cell.myTitleLabel.text = items[indexPath.row].title!
        cell.descriptionLabel.text = items[indexPath.row].details!
        let date = items[indexPath.row].date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        cell.dateLabel.text = dateFormatter.string(from: date)
        tableView.rowHeight = 65
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected = tableView.cellForRow(at: indexPath) as! TodoTableViewCell
        if selected.checkMarkLabel.alpha == 0 {
            selected.checkMarkLabel.alpha = 1
        } else {
            selected.checkMarkLabel.alpha = 0
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let object = items[indexPath.row]
        items.remove(at: indexPath.row)
        managedObjectContext.delete(object)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("couldn't save", error)
        }
        
        tableView.reloadData()
    }
    
    // MARK: Core Data Functions
    func fetchAllItems() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [TodoItem]
            for item in items {
                print(item)
            }
        } catch {
            print("failed in fetch all items", error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Delegate Functions

    func addItem(title: String, details: String, date: Date) {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "TodoItem", into: managedObjectContext) as! TodoItem
        newItem.title = title
        newItem.details = details
        newItem.date = date
        
        do {
            try managedObjectContext.save()
            print("Successfully saved")
        } catch {
            print(error)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}

