//
//  ProductImgCell.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

class ProductImgCell: UICollectionViewCell {

// MARK: STATIC LET -
    static let identifier = "ProductImgCell"
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var img: UIImageView!
    
// MARK: LIFE CYCLE CELL FUNC -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
        img.layer.cornerRadius = 20
    }
    
// MARK: SET METHODS -
    func setContent(imgUrl: String) {
        img.DownloadImgFromURL(uri: imgUrl)
    }
}
