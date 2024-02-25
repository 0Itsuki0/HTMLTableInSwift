//
//  ColumnCell.swift
//  HTMLTableUIKITDemo
//
//  Created by Itsuki on 2024/02/25.
//

import UIKit

class ColumnCell: UICollectionViewCell,UITableViewDelegate, UITableViewDataSource {

    
    static let cellIdentifier = String(describing: ColumnCell.self)
    
    @IBOutlet weak var rowTableView: UITableView!
    
    var rows: Array<String> = []
    var rowHeights: Array<CGFloat> = []
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rowTableView.dataSource = self
        rowTableView.delegate = self
        rowTableView.isScrollEnabled = false
        
        rowTableView.register(UINib(nibName: ItemCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ItemCell.cellIdentifier)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rowTableView.layer.borderColor = UIColor.lightGray.cgColor
        rowTableView.layer.borderWidth = 1.0
        rowTableView.layer.masksToBounds = true
    }

    func configure(rows: Array<String>, rowHeights: Array<CGFloat>) {
        if (rows != self.rows && rowHeights != self.rowHeights) {
            self.rows = rows
            self.rowHeights = rowHeights
            rowTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rowTableView.dequeueReusableCell(withIdentifier: ItemCell.cellIdentifier, for: indexPath) as! ItemCell
        cell.label.text = rows[indexPath.item]
        return cell
    }
}
