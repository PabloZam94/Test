//
//  SearchViewController.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

struct objecLogin: Codable {
    var username: String
    var password: String
    var request_token: String
}

class SearchViewController: UIViewController {
    
// MARK: PROTOCOL VAR -
    var presenter: SearchPresenterProtocol?
    var listSearch = [Result]()
    
// MARK: PROPERTIES -
    let loader = LoaderViewController.showLoader()
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainStack: UIStackView!
    
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var emptyImg: UIImageView!
    
// MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        configTableView()
    }
    
// MARK: SETUP FUNC -
    func configTableView() {
        mainTableView.register(UINib(nibName: ListViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListViewCell.identifier)
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
    

// MARK: GENERAL FUNC -
    func refreshData(data: SearchModel) {
        listSearch = data.results ?? []
        showEmptyholders(isEmpty: listSearch.count == 0 ? true : false)
        lblEmpty.text = "No encontramos reusltados para \(mainSearchBar.text ?? "...")"
        mainTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loader.dismiss(animated: false)
        }
    }
    
    func showEmptyholders(isEmpty: Bool) {
        mainStack.isHidden = isEmpty
        lblEmpty.isHidden = !isEmpty
        emptyImg.isHidden = !isEmpty
    }
}

// MARK: EXTENSIONS -
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as? ListViewCell else { return UITableViewCell() }
        cell.setContent(data: listSearch[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.instatiateProductInfo(vc: self,itemID: listSearch[indexPath.row].id ?? "0")
    }
}

extension SearchViewController: SearchViewProtocol {
    func successGetSearch(data: SearchModel) {
        refreshData(data: data)
        
    }
    
    func failureGetSearch(error: RequestError) {
        self.loader.dismiss(animated: false)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.layoutIfNeeded()
        searchBar.showsCancelButton = searchBar.text != "" ? true : false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          if let searchText = searchBar.text {
              print("Search text: \(searchText)")
              self.present(self.loader, animated: false)
              presenter?.callReuquestSearch(query: searchText)
          }
      }

      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchBar.resignFirstResponder()
          searchBar.text = nil
          searchBar.layoutIfNeeded()
          searchBar.showsCancelButton = false
          
      }
}
