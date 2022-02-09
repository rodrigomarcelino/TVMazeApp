//
//  SeriesListViewController.swift
//  TVMazeApp
//
//  Created by Digao on 08/02/22.
//

import UIKit
import RxSwift

class SeriesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: SeriesListViewModel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.getSeries()
        configCollectionView()
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.masksToBounds = false
        collectionView.register(UINib(nibName: "SerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SerieCollectionViewCell.identifier)
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
                self.collectionView.reloadData()
            })
            .disposed(by: bag)
    }

}

extension SeriesListViewController {
    static func newInstance(viewModel: SeriesListViewModel) -> SeriesListViewController {
        let controller = SeriesListViewController(nibName: "SeriesListViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}

extension SeriesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.seriesList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let serie = viewModel.seriesList?[indexPath.row], let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SerieCollectionViewCell.identifier, for: indexPath) as? SerieCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setUp(name: serie.name, imageModel: serie.image)
        return cell
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-10, height: 150)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 15
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
