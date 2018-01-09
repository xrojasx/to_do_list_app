//
//  ViewController.swift
//  beltExam2
//
//  Created by Ricardo Rojas on 11/19/17.
//  Copyright © 2017 Ricardo Rojas. All rights reserved.
//

import UIKit
import CoreData

class toDoListTableViewController: UITableViewController, addItemViewControllerDelegate {

    var items = [ToDoItems]()
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! toDoListTableViewCell
        cell.toDoItemLabel.text = items[indexPath.row].item
        
        return cell
    }
    
    @IBAction func AddItemButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addItemSegue", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addItemSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addToListViewController = navigationController.topViewController as! addToListViewController
        addToListViewController.delegate = self
        
        if sender is IndexPath{
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addToListViewController.item = item.item!
            addToListViewController.indexPath = indexPath
            
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteItem(item: items[indexPath.row])
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    func cancelButtonPressed(by controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    func itemSaved (by controller: UIViewController, with text: String, at indexPath: NSIndexPath?){
        if let ip = indexPath {
            let item = items[ip.row]
            item.item = text
        } else {
            
            let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoItems", into: moc) as! ToDoItems
            item.item = text
            items.append(item)
        }
        do {
            try moc.save()
        } catch {
            print ("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
}
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItems")
        do {
            let result = try moc.fetch(request)
            items = result as! [ToDoItems]
        } catch {
            print("\(error)")
        }
    }
    func deleteItem(item: ToDoItems){
        self.moc.delete(item)
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print("\(error)")
            }
        }
    }
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let doneItem = NSEntityDescription.insertNewObject(forEntityName: "DoneItems", into: moc) as! DoneItems
        
        doneItem.item = items[sender.tag].item
        print(sender.tag)
        doneItem.date = NSDate() as Date
        moc.delete(items[sender.tag])
        if moc.hasChanges {
            do {
                try moc.save()
                fetchAllItems()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
}

