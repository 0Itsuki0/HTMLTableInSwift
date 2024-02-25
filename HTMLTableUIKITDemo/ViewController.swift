//
//  ViewController.swift
//  TableViewInCellDemo
//
//  Created by Itsuki on 2024/02/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    
    var itmeOutsideTable = ["item 1 outsie", "item 2 outsie", "item 3 outsie", ]
    var tableItems: Array<Array<String>> = [
        ["item 1-1 in table cell super long ", "item 1-2 ", "item 1-3 in table cell super long \nsuper long \nsuper long \nsuper long \nsuper long \nsuper long \nsuper long \nsuper long \nEND!!! ", "1-4"],
        ["item 2-1 in table cell", "item 2-2 in table cell", "item 2-3 in table cell", "item 2-4 in table cell"],
        ["item 3-1 in table cell", "item 3-2 in table cell", "item 3-3 in table cell", "item 3-4 in table cell"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: TableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TableCell.cellIdentifier)
        mainTableView.register(UINib(nibName: RegularCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: RegularCell.cellIdentifier)
        
        mainTableView.estimatedRowHeight = 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else {
            return itmeOutsideTable.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: TableCell.cellIdentifier, for: indexPath) as! TableCell
            cell.configure(rowsOfColumns: tableItems)
            return cell

        } else {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: RegularCell.cellIdentifier, for: indexPath) as! RegularCell
            cell.label.text = itmeOutsideTable[indexPath.row]
            return cell
        }
    }
}
