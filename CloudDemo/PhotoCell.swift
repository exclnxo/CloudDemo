//
//  PhotoCell.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet var iv: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.activityIndicator.stopAnimating()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iv.image = UIImage()
        self.activityIndicator.isHidden = true
    }
    
}
