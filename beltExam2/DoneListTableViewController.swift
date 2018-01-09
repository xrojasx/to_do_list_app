//
//  DoneListTableViewController.swift
//  beltExam2
//
//  Created by Ricardo Rojas on 11/19/17.
//  Copyright © 2017 Ricardo Rojas. All rights reserved.
//

import UIKit
import CoreData

class DoneListTableViewController: UITableViewController {
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [DoneItems]()
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "EEE MMM yy"
        fetchAllItems()
        
    }
    override func viewDidAppear(_ animated : Bool) {
        fetchAllItems()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DoneItems")
        do {
            let result = try moc.fetch(request)
            items = result as! [DoneItems]
        } catch {
            print("\(error)")
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doneListCell", for: indexPath) as! doneItemTableViewCell
        cell.doneItemLabel!.text = items[indexPath.row].item
        
        let date = formatter.string(from: items[indexPath.row].date!)
        cell.doneDateLabel?.text = date
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteItem(item: items[indexPath.row])
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    func deleteItem(item: DoneItems){
        self.moc.delete(item)
        if moc.hasChanges {
            do {
                try moc.save()
                print("Success with delete")
            } catch {
                print("\(error)")
            }
        }
    }
}

