//
//  ShowListViewModel.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import Foundation
import RxCocoa
import Promise

class ShowListViewModel: NSObject {
    var viewState = ViewState()
    
    var showList: [ShowModel]? = []
    
    let showsService: ShowsService!

    struct ViewState {
        let loading = BehaviorRelay<Bool>(value: false)
        let seviceSuccess = BehaviorRelay<Void>.init(value: ())
    }
    
    init(showsService: ShowsService? = ShowsService()) {
        self.showsService = showsService
    }
    
    func getShows() {
        viewState.loading.accept(true)
        showsService.getShowsPerPage(page: 0).then { [self] result in
            self.showList?.append(contentsOf: result)
            self.viewState.seviceSuccess.accept(())
        }.catch { _ in
            self.viewState.loading.accept(false)
            //TODO show empty view or error service
        }
    }
    
}
