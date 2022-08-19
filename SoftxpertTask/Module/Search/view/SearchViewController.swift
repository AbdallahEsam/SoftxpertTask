//
//  SearchViewController.swift
//  SoftxpertTask
//
//  Created by Macintosh on 18/08/2022.
//

import UIKit
protocol SearchViewProtocol: AlertHandlerViewProtocol, LoaderViewProtocol {
    func reloadData()
    func showEmptyView()
    func navigateToDetailsWithID(_ id: String)
}

class SearchViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellType: SearchListTableViewCell.self)
            tableView.rowHeight = 135
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: SearchPresenterProtocol!
    var router: SearchViewToRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = Localization.string(for: .searchRecipeTitle)
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = presenter.getSearchScopeTitles()
        searchBar.showsScopeBar = false
        searchBar.selectedScopeButtonIndex = 0
        self.definesPresentationContext = true
    }


   

}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if searchBar.text == "" {
            let replacementStringIsLegal = text.rangeOfCharacter(from: NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ").inverted) == nil
            
            if !replacementStringIsLegal {
                return false
            }
        }else{
            let replacementStringIsLegal = text.rangeOfCharacter(from: NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ & \n").inverted) == nil
            
            if !replacementStringIsLegal {
                return false
            }
        }
        
        return true
    }
    
   
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let index = selectedScope
        let text = searchBar.text
        presenter.search(searchKey: text, filterIndex: index)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            doSomeLogic()
        }
    }
    
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       doSomeLogic()
        
    }
    
    private func doSomeLogic(){
        let index = searchBar.selectedScopeButtonIndex
        let text = searchBar.text
        searchBar.showsScopeBar = !searchBar.text!.isEmpty
        searchBar.selectedScopeButtonIndex = searchBar.text!.isEmpty ? 0 : searchBar.selectedScopeButtonIndex
        presenter.search(searchKey: text, filterIndex: index)
        view.endEditing(true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchListTableViewCell.self, for: indexPath)
        cell.configCell(vm: presenter.getViewModelByIndex(index: indexPath.row))
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.tableDidScrollToIndex(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tableDidSelectRowAtIndex(index: indexPath.row)
    }
    
}

extension SearchViewController: SearchViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
        tableView.removeBackGroundView()
    }
    
    func showEmptyView() {
        
        tableView.setEmptyData(image: .emptyImage, description: Localization.string(for: .noSearch), title: Localization.string(for: .sorry), delegate: nil)
    }
    
    func navigateToDetailsWithID(_ id: String) {
        router.navigateToDetailsWithID(id)
    }
    
    
}

