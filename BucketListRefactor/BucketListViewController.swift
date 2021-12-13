//
//  BucketListViewController.swift
//  BucketListRefactor
//
//  Created by Linah abdulaziz on 09/05/1443 AH.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController , AddItemViewControllerDelegate {
    
    var items = ["Go To Moon","Eat a Candy Bar","Swim in Amazon","Run A way"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "Edititemseque", sender: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "Edititemseque", sender: indexPath)

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    // prepare with sender type
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if sender is UIBarButtonItem{
         let destination = segue.destination as! UINavigationController

         let addItem = destination.topViewController as! AddItemViewController

         addItem.delegate = self
        }
        else if sender is IndexPath{
            let destination = segue.destination as! UINavigationController

            let addItem = destination.topViewController as! AddItemViewController

            addItem.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]

            addItem.item = item
            addItem.indexPath = indexPath
        }



    }

    
    
    
    
    

    

    func CancelButtonPressed(By controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemViewController, with text: String, at indexPath: NSIndexPath?) {
        print("Recieved \(text )")
        
        if let ip = indexPath{
            items[ip.row] = text
        }
        else{
            items.append(text)
            
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
