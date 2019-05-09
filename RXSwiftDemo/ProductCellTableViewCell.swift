//
//  ProductCellTableViewCell.swift
//  RXSwiftDemo
//
//  Created by kong on 2019/5/6.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit
import SDWebImage

final class ProductCellTableViewCell: UITableViewCell {

    @IBOutlet private var productImage: UIImageView!
    
    @IBOutlet private var name: UILabel!
    
    @IBOutlet private var subName: UILabel!
    
    @IBOutlet private var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImage.layer.cornerRadius = 10.0
        productImage.layer.masksToBounds = true
    }
    
    func bind(_ model: Product) {
        
        name.text = model.name
        subName.text = model.subName
        price.text = "￥ " + "\(model.price)"
        
        guard let url = URL(string: model.imageURL + "?imageView2/1/q/90/w/240/h/240/") else {
            return
        }
        productImage.sd_setImage(with: url, completed: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
