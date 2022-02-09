//
//  SearchShowViewModel.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import Foundation
import RxCocoa
import Promise

class SearchShowViewModel: NSObject {
    var viewState = ViewState()
    
    var searchShowList: [SearchShowModel]? = []
    
    var searchQuery: String = "" {
        didSet{
            getShows(searchText: searchQuery)
        }
    }
    
    let showsService = ShowsService()

    struct ViewState {
        let loading = BehaviorRelay<Bool>(value: false)
        let seviceSuccess = BehaviorRelay<Void>.init(value: ())
    }
    
    func getShows(searchText: String?) {
        viewState.loading.accept(true)
        showsService.searchShows(searchText: searchText ?? "").then { [self] result in
            self.searchShowList?.append(contentsOf: result)
            self.viewState.seviceSuccess.accept(())
        }.catch { _ in
            self.viewState.loading.accept(false)
            //TODO show empty view or error service
        }
    }
    
}

