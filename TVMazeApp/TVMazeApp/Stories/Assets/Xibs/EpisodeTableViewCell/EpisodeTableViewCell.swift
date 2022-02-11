//
//  EpisodeTableViewCell.swift
//  TVMazeApp
//
//  Created by Digao on 10/02/22.
//

import UIKit
import Kingfisher

class EpisodeTableViewCell: UITableViewCell {

    //MARK- Constants
    static let identifier = "episodeTableViewCell"
    static let className = "EpisodeTableViewCell"
    
    //MARK:- View variables
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setup(episode: Int, name: String, image: ImageModel?) {
        episodeLabel.text = "Episode \(episode)"
        nameLabel.text = name
        setImage(imageModel: image)
    }
    
    private func setImage(imageModel: ImageModel?) {
        activityIndicator.startAnimating()
        guard let imageModel = imageModel, let imageUrlString = imageModel.medium, let imageUrl = URL(string: imageUrlString) else {
            activityIndicator.stopAnimating()
            episodeImageView.image = UIImage(named: "placeHolder")
            return
        }
        let resource = ImageResource(downloadURL: imageUrl)
        episodeImageView.kf.setImage(with: resource, completionHandler: { result in
            self.activityIndicator.stopAnimating()
            switch result {
            case .success(_):
                break
            case .failure:
                self.episodeImageView.image = UIImage(named: "placeHolder")
            }
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeLabel.text = ""
        nameLabel.text = ""
        episodeImageView.image = nil
    }
}
