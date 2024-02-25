//
//  TableCell.swift
//  TableViewInCellDemo
//
//  Created by Itsuki on 2024/02/23.
//

import UIKit

class TableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    static let cellIdentifier = String(describing: TableCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    var rowHeights: Array<CGFloat> = []
    var columnWidth: Array<CGFloat> = []
    var columnOfRows: Array<Array<String>> = []
    var columnHeight: CGFloat = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        
        collectionView.register(UINib(nibName: ColumnCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: ColumnCell.cellIdentifier)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            layout.minimumInteritemSpacing = 1000
//            layout.minimumLineSpacing = 10
            collectionView.collectionViewLayout = layout
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.layer.borderColor = UIColor.clear.cgColor
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.cornerRadius = 4.0
        collectionView.layer.masksToBounds = true
    }
    
    
    
    func configure(rowsOfColumns: Array<Array<String>>) {
        let columnOfRows = rowsOfColumns.transpose()
        
        // fix column width, dynamic height
        var rowHeights: Array<CGFloat> = Array(repeating: LayoutConstants.defaultRowHeight, count: rowsOfColumns.count)
        for i in 0..<rowsOfColumns.count {
            if let itemMaxLength = rowsOfColumns[i].max(by: {$1.count > $0.count}) {
                rowHeights[i] =  itemMaxLength.height(withConstrainedWidth: LayoutConstants.defaultColumnWidth, font: LayoutConstants.defaultFont) + 20 // for padding
            }
        }
        let columnWidth: Array<CGFloat> = Array(repeating: LayoutConstants.defaultColumnWidth, count: columnOfRows.count)
        
        self.rowHeights = rowHeights
        self.columnWidth = columnWidth
        self.columnHeight = rowHeights.reduce(0, +)
        self.collectionViewHeightConstraint.constant = self.columnHeight
        self.columnOfRows = columnOfRows
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.columnWidth[indexPath.item], height: self.columnHeight)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // number of columns
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnOfRows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColumnCell.cellIdentifier, for: indexPath) as! ColumnCell
        let column = columnOfRows[indexPath.item]
        cell.configure(rows: column, rowHeights: rowHeights)
        return cell
    }
    
}
