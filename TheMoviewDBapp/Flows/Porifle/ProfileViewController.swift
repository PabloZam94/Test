//
//  ProfileViewController.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
// MARK: PROTOCOL VAR -
    var presenter: ProfilePresenterProtocol?
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblFavoritesTitle: UILabel!
    @IBOutlet weak var favoritesCollection: UICollectionView!
    
// MARK: PROPERTIES -
    var sessionID = ""
    var page = 1
    var arrayResults = [MoviesResults]()

// MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFavoritescollection()
        presenter?.requestAccountDetail(url: Endpoints.BaseURL + Endpoints.Account + Constats.oldPathAPI + Constats.apiKey + "&session_id=\(sessionID)")
    }
    
// MARK: SETUP FUNC -
    func setupAlertError(alrtTitle: String, message: String) {
        let alert = UIAlertController(title: alrtTitle, message: message, preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try again", style: .default) { action in
            self.presenter?.requestAccountDetail(url: Endpoints.BaseURL + Endpoints.Account + Constats.oldPathAPI + Constats.apiKey + "&session_id=\(self.sessionID)")
        }
        alert.addAction(tryAgain)
        self.present(alert, animated: true)
    }
    
    func setupUI() {
        imgUser.layoutIfNeeded()
        imgUser.layer.cornerRadius = imgUser.frame.height / 2
    }
    
    func setupFavoritescollection() {
        favoritesCollection.register(UINib(nibName: MovieCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionCell.identifier)
        favoritesCollection.delegate = self
        favoritesCollection.dataSource = self
    }
    
// MARK: GENRAL FUNC -
    func fillData(data: AccountResponse) {
        imgUser.DownloadImgFromURL(uri: Endpoints.ImagePath + (data.avatar?.tmdb?.avatar_path ?? ""))
        lblUserName.text = data.username ?? ""
    }

}

// MARK: EXTENSIONS -
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.identifier, for: indexPath) as! MovieCollectionCell
        
        cell.movieImg.DownloadImgFromURL(uri: Endpoints.ImagePath + (arrayResults[indexPath.item].poster_path ?? ""))
        cell.lblMovieName.text = arrayResults[indexPath.item].title
        cell.lblDate.text = arrayResults[indexPath.item].release_date
        cell.lblDescription.text = arrayResults[indexPath.item].overview
        cell.lblRate.text = "★ \(arrayResults[indexPath.item].vote_average ?? 0.0)"
        cell.setupUI()
        
        if arrayResults.count > 2 {
            if indexPath.item == arrayResults.count - 1 {
                page += 1
                presenter?.requestFavoritesMovies(url: Endpoints.BaseURL + Endpoints.Account + "/1/" + Endpoints.FavoriteMovies + Constats.oldPathAPI + Constats.apiKey + "&session_id=" + sessionID + "&language=en-US&sort_by=created_at.asc&page=\(page)")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        favoritesCollection.layoutIfNeeded()
        let width = favoritesCollection.frame.width - 10
        let hight = (width / 2) + 140
        return CGSize(width: width / 2 , height: hight) //258
    }
    
}

extension ProfileViewController: ProfileViewProtocol {
    func successGetAccountDetail(data: AccountResponse) {
        fillData(data: data)
        presenter?.requestFavoritesMovies(url: Endpoints.BaseURL + Endpoints.Account + "/1/" + Endpoints.FavoriteMovies + Constats.oldPathAPI + Constats.apiKey + "&session_id=" + sessionID + "&language=en-US&sort_by=created_at.asc&page=\(page)")
    }
    
    func failGetAccountDetail() {
        print("Error to get account detail")
    }
    
    func successGetFavoritesMovies(data: MoviesResponse) {
        data.results?.forEach({ item in
            arrayResults.append(item)
        })
        favoritesCollection.reloadData()
    }
    
    func failGetFavoritesMovies() {
        setupAlertError(alrtTitle: "We´re sorry", message: "Somethings, wrong, please try again")
    }
    
}
