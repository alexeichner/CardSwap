//
//  InboxTVC.swift
//  CardSwap
//
//  Created by Alex Eichner on 12/17/23.
//

import UIKit

class InboxTVC: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreData()
        self.tableView.reloadData()
    }
    
    func getCoreData() {
        
    }
}
