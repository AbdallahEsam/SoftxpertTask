//
//  SearchInteractor.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation
protocol SearchInteractorPresenterProtocol: AnyObject {
    func fetchDataSuccessfully(data: SearchRecipe)
    func fetchAnError(error: AppError)
}
protocol SearchInteractorProtocol{
    func search(searchKey: String?, filter: FilterEnum?, from: Int)
}

class SearchInteractor{
    private weak var presenter: SearchInteractorPresenterProtocol!
    private let repo: MainRepoProtocol
    init(repo: MainRepoProtocol, presenter: SearchInteractorPresenterProtocol){
        self.repo = repo
        self.presenter = presenter
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    func search(searchKey: String?, filter: FilterEnum?, from: Int) {
        repo.search(searchKey: searchKey, filter: filter, from: from) { [weak self] rslt in
            guard let self = self else{return}
            switch rslt {
            case .success(let data):
                self.presenter.fetchDataSuccessfully(data: data)
            case .failure(let error):
                self.presenter.fetchAnError(error: error)
            }
        
        }
    }
}
