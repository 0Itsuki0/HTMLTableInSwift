//
//  ItemCell.swift
//  HTMLTableUIKITDemo
//
//  Created by Itsuki on 2024/02/25.
//

import UIKit

class ItemCell: UITableViewCell {
    static let cellIdentifier = String(describing: ItemCell.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = LayoutConstants.defaultFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.masksToBounds = true
    }
}
