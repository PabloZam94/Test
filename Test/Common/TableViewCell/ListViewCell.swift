//
//  ListViewCell.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

class ListViewCell: UITableViewCell {

// MARK: STATIC LET -
    static let identifier = "ListViewCell"
    
// MARK: @OUTLET -
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblBottom: UILabel!
    
    // MARK: OVERRIDE FUNC -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
// MARK: SET METHODS -
    func setContent(data: Result) {
        productImg.DownloadImgFromURL(uri: data.thumbnail ?? "")
        lblTitle.text = data.title ?? ""
        lblPrice.text = data.price?.currencyFormat()
        lblBottom.text = "Disponibilidad (\(data.availableQuantity ?? 0))"
        lblSubtitle.isHidden = data.acceptsMercadopago ?? false ? false : true
    }
    
}
