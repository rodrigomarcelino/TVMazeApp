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
    
    var lastPageCall = 0
    var hasMorePages = true
    var hasCalledService = false

    struct ViewState {
        let loading = BehaviorRelay<Bool>(value: false)
        let seviceSuccess = BehaviorRelay<Void>.init(value: ())
    }
    
    init(showsService: ShowsService? = ShowsService()) {
        self.showsService = showsService
    }
    
    func getShows(page: Int) {
        hasCalledService = true
        viewState.loading.accept(true)
        showsService.getShowsPerPage(page: page).then { [self] result in
            hasCalledService = false
            if result.isEmpty {
                hasMorePages = false
                return
            }
            self.showList?.append(contentsOf: result)
            self.viewState.seviceSuccess.accept(())
        }.catch { _ in
            self.hasCalledService = false
            self.viewState.loading.accept(false)
            //TODO show empty view or error service
        }
    }
    
    func callNewPage() {
        if hasMorePages && !hasCalledService {
            lastPageCall += 1
            getShows(page: lastPageCall)
        }
    }
    
}
