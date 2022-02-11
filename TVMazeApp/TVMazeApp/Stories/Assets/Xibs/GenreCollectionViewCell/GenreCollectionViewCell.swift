//
//  GenreCollectionViewCell.swift
//  TVMazeApp
//
//  Created by Digao on 10/02/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    //MARK- Constants
    static let identifier = "genreCollectionViewCell"
    static let className = "GenreCollectionViewCell"

    //MARK:- View variables
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius()
    }
    
    func setCornerRadius() {
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
    
    func setup(genre: String) {
        genreLabel.text = genre
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreLabel.text = ""
    }
}
