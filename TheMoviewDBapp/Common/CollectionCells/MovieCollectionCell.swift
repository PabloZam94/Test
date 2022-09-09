//
//  MovieCollectionCell.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

// MARK: STATIC LET -
    static let identifier = "MovieCollectionCell"
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var movieCard: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
// MARK: LIFE CYCLE CELL FUNC -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
        movieCard.layer.cornerRadius = 20
        movieImg.layer.cornerRadius = 20
    }

}
