//
//  SearchShowViewController.swift
//  TVMazeApp
//
//  Created by Digao on 08/02/22.
//

import UIKit
import RxSwift

class SearchShowViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: SearchShowViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configCollectionView()
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.masksToBounds = false
        collectionView.register(UINib(nibName: "ShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
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

extension SearchShowViewController {
    static func newInstance(viewModel: SearchShowViewModel) -> SearchShowViewController {
        let controller = SearchShowViewController(nibName: "SearchShowViewController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
}


//MARK:- Search View Methods
extension SearchShowViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchQuery = searchBar.text ?? ""
        self.dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            if searchText.isEmpty {
                self.viewModel.searchQuery = searchText
            }
        }
    }
}

//MARK:- Collection view methods
extension SearchShowViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchShowList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let show = viewModel.searchShowList?[indexPath.row].show, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setUp(name: show.name, imageModel: show.image)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let show = viewModel.searchShowList?[indexPath.row].show else {
            return
        }
        let showDetailViewController = ShowDetailViewController.newInstance(viewModel: ShowDetailViewModel(showModel: show))
        navigationController?.pushViewController(showDetailViewController, animated: true)
    }
}
