//
//  ShowDetailViewController.swift
//  TVMazeApp
//
//  Created by Digao on 08/02/22.
//

import UIKit
import RxSwift
import Kingfisher

class ShowDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var episodesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: ShowDetailViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        populateView()
        configCollectionView()
        configTableView()
        viewModel.getEpisodes()
    }
    
    func populateView() {
        nameLabel.text = viewModel.showModel?.name
        setImage()
        scheduleLabel.text = viewModel.schedule()
        summaryLabel.text = viewModel.showModel?.summary?.html2String
        let tap = UITapGestureRecognizer(target: self, action:  #selector(openSummary))
        summaryLabel.addGestureRecognizer(tap)
    }
    
    private func setImage() {
        activityIndicator.startAnimating()
        guard let imageModel = viewModel.showModel?.image, let imageUrlString = imageModel.medium, let imageUrl = URL(string: imageUrlString) else {
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
    
    func configTableView() {
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(UINib(nibName: EpisodeTableViewCell.className, bundle: nil), forCellReuseIdentifier: EpisodeTableViewCell.identifier)
    }
    
    func configCollectionView() {
        if let flowLayout = genreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.layer.masksToBounds = false
        genreCollectionView.register(UINib(nibName: GenreCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
    }
    
    func bind() {
        viewModel.viewState.loading
            .observe(on:MainScheduler.instance)
            .subscribe(onNext: { loading in
            })
            .disposed(by: bag)
        viewModel.viewState.seviceSuccess
            .observe(on:MainScheduler.instance)
            .subscribe(onNext: {
                self.episodesTableView.reloadData()
            })
            .disposed(by: bag)
    }
    
    @objc func openSummary() {
        print("tap working")
    }
}

extension ShowDetailViewController {
    static func newInstance(viewModel: ShowDetailViewModel) -> ShowDetailViewController {
        let controller = ShowDetailViewController(nibName: "ShowDetailViewController", bundle: Bundle.main)
        controller.viewModel = viewModel
        return controller
    }
}

//MARK:- Collection View Methods
extension ShowDetailViewController :  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.showModel?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        
        cell.setup(genre: viewModel.showModel?.genres?[indexPath.row] ?? "")
        
        return cell
    }
}

//MARK:- Table view methods
extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.episodesPerSeason.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let season = viewModel.seasonKeys[section]
        return viewModel.episodesPerSeason[season]?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let season = viewModel.seasonKeys[section]
        return "Season \(season)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let season = viewModel.seasonKeys[indexPath.section]
        guard let episode = viewModel.episodesPerSeason[season]?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(episode: episode.number ?? 0, name: episode.name ?? "", image: episode.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let episode = viewModel.episodeList?[indexPath.row] {
            let episodeDetailViewController = EpisodeDetailViewController.newInstance(viewModel: EpisodeDetailViewModel(episode: episode))
            navigationController?.pushViewController(episodeDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
