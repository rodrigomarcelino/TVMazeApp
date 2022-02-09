//
//  SeriesListViewModel.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import Foundation
import RxCocoa
import Promise

class SeriesListViewModel: NSObject {
    var viewState = ViewState()
    
    var seriesList: [ShowModel]? = []
    
    let seriesService: SeriesService!

    struct ViewState {
        let loading = BehaviorRelay<Bool>(value: false)
        let seviceSuccess = BehaviorRelay<Void>.init(value: ())
    }
    
    init(seriesService: SeriesService? = SeriesService()) {
        self.seriesService = seriesService
    }
    
    func getSeries() {
        viewState.loading.accept(true)
        seriesService.getSeriesPerPage(page: 0).then { [self] result in
            self.seriesList?.append(contentsOf: result)
            self.viewState.seviceSuccess.accept(())
        }.catch { _ in
            self.viewState.loading.accept(false)
            //TODO show empty view or error service
        }
    }
    
}
