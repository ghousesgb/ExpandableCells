//
//  CustomeCellTableViewCell.swift
//  ExpandableSections
//
//  Created by Ghouse Basha Shaik on 27/11/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class CustomeCell: UITableViewCell {

    var link: ViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let starButton = UIButton(type: .system)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
        starButton.tintColor = UIColor.gray
        starButton.addTarget(self, action: #selector(handleTapEvent), for: .touchUpInside)
        accessoryView = starButton
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func handleTapEvent() {
        link?.setUnSetFavorite(cell: self)
    }
}
