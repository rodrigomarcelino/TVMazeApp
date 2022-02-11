//
//  ShowCollectionViewCell.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import UIKit
import Kingfisher

class ShowCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Constants
    static let identifier = "showCollectionViewCell"
    
    //MARK:- View variables
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setUp(name: String?, imageModel: ImageModel?) {
        nameLabel.text = name ?? ""
        setImage(imageModel: imageModel)
        setCornerRadius()
    }
    
    private func setImage(imageModel: ImageModel?) {
        activityIndicator.startAnimating()
        guard let imageModel = imageModel, let imageUrlString = imageModel.medium, let imageUrl = URL(string: imageUrlString) else {
            activityIndicator.stopAnimating()
            posterImageView.image = UIImage(named: "placeHolder")
            return
        }
        let resource = ImageResource(downloadURL: imageUrl)
        posterImageView.kf.setImage(with: resource, completionHandler: { result in
            self.activityIndicator.stopAnimating()
            switch result {
            case .success(_):
                break
            case .failure:
                self.posterImageView.image = UIImage(named: "placeHolder")
            }
        })
    }
    
    func setCornerRadius() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        nameLabel.text = ""
    }
}
