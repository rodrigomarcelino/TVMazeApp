//
//  EpisodeDetailViewController.swift
//  TVMazeApp
//
//  Created by Digao on 08/02/22.
//

import UIKit
import RxSwift
import Kingfisher

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: EpisodeDetailViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    func configViews() {
        nameLabel.text = viewModel.episode.name ?? ""
        infoLabel.text = viewModel.episodeInfo()
        summaryLabel.text = viewModel.episode.summary?.html2String
        setImage()
    }
    
    private func setImage() {
        activityIndicator.startAnimating()
        guard let imageModel = viewModel.episode.image, let imageUrlString = imageModel.medium, let imageUrl = URL(string: imageUrlString) else {
            activityIndicator.stopAnimating()
            imageView.image = UIImage(named: "placeHolder")
            return
        }
        let resource = ImageResource(downloadURL: imageUrl)
        imageView.kf.setImage(with: resource, completionHandler: { result in
            self.activityIndicator.stopAnimating()
            switch result {
            case .success(_):
                break
            case .failure:
                self.imageView.image = UIImage(named: "placeHolder")
            }
        })
    }
}

extension EpisodeDetailViewController {
    static func newInstance(viewModel: EpisodeDetailViewModel) -> EpisodeDetailViewController {
        let controller = EpisodeDetailViewController(nibName: "EpisodeDetailViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}
