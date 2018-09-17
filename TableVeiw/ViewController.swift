//
//  ViewController.swift
//  TableVeiw
//
//  Created by Citizen on 9/17/18.
//  Copyright © 2018 Citizen. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var newTableView: UITableView!
    
    let identifer = "newCell"
    var arr = ["1", "2", "3", "4"]
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    @IBAction func editTable(_ sender: Any) {
        newTableView.isEditing = !newTableView.isEditing
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        let number = arr[indexPath.row]
        cell.textLabel?.text = number
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = arr[sourceIndexPath.row]
        arr.remove(at: sourceIndexPath.row)
        arr.insert(item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        print(action)
        if action == #selector(copy(_:)) {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            let cell = tableView.cellForRow(at: indexPath)
            let pastBoard = UIPasteboard.general
            pastBoard.string = cell?.textLabel?.text
        }
    }
    
}
