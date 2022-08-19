//
//  SearchPresenter.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation


protocol SearchPresenterProtocol {
    func search(searchKey: String?, filterIndex: Int)
    var numberOfRow: Int {get}
    func getViewModelByIndex(index: Int) -> SearchListViewModel
    func getSearchScopeTitles() -> [String]
    func tableDidScrollToIndex(index: Int)
    func tableDidSelectRowAtIndex(index: Int)
}

class SearchPresenter{
    
    private weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol!
    
    init(view: SearchViewProtocol) {
        self.view = view
        
    }
    
    private var from: Int = 0
    private var searchKey: String?
    private var filter: FilterEnum?
    private var searchData: [Hit] = []
    private var canLoadMore: Bool = false
    private var isLoading: Bool = false
    private var searchScopeTitles = FilterEnum.allCases
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func tableDidSelectRowAtIndex(index: Int) {
        let item = searchData[index]
        guard let id = item.links?.linksSelf?.href?.slice(from: "v2/", to: "?") else{return}
        view?.navigateToDetailsWithID(id)
    }
    
    func tableDidScrollToIndex(index: Int) {
        guard !isLoading, canLoadMore else{return}
        guard index == searchData.count - 1 else{return}
        loadMore(from: from + 10)
    }
    
    func getSearchScopeTitles() -> [String] {
        return searchScopeTitles.map({$0.displayName})
    }
    
    var numberOfRow: Int {
        return searchData.count
    }
    
    func getViewModelByIndex(index: Int) -> SearchListViewModel {
        let item = searchData[index].recipe
        return .init(imageURL: item?.image, title: item?.label, source: item?.source, health: item?.healthLabels?.joined(separator: ","))
    }
    
    func search(searchKey: String?, filterIndex: Int) {
        guard !searchKey!.isEmpty else{
            self.searchKey = nil
            self.filter = nil
            self.searchData = []
            self.view?.reloadData()
            return}
        self.searchKey = searchKey
        self.filter = filterIndex == 0 ? nil : searchScopeTitles[filterIndex]
        from = 0
        loadMore(from: from)
    }
    
   
    
    private func loadMore(from: Int){
        view?.startLoading()
        isLoading = true
        interactor.search(searchKey: searchKey, filter: filter, from: from)
    }
    
    private func validateData(_ data: SearchRecipe) {
        if data.count == 0 {
            searchData = data.hits ?? []
        }else{
            searchData.append(contentsOf: data.hits ?? [])
        }
        
        if searchData.isEmpty {
            view?.reloadData()
            view?.showEmptyView()
        }else{
            view?.reloadData()
        }
    }
    
}

extension SearchPresenter: SearchInteractorPresenterProtocol {
    
    
    func fetchDataSuccessfully(data: SearchRecipe) {
        view?.stopLoading()
        self.from = data.from ?? 0
        self.canLoadMore = data.more ?? false
        self.isLoading = false
        validateData(data)
        
    }
    
    func fetchAnError(error: AppError) {
        view?.stopLoading()
        self.isLoading = false
        self.view?.showAlert(with: error.description, title: .error)
    }
    
    
}
