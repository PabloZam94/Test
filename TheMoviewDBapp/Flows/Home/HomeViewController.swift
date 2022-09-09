//
//  HomeViewController.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
// MARK: PROTOCOL VAR -
    var presenter: HomePresenterProtocol?
    
// MARK: PROPERTERS -
    var sessionID = ""
    var language = "en-US"
    var page = 1
    var arrayResults = [MoviesResults]()
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var topSegmentCategories: UISegmentedControl!
    @IBOutlet weak var moviesCollection: UICollectionView!
    
// MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupNavBarConfig()
        setupUI()
        presenter?.requestMovies(url: Endpoints.BaseURL + Endpoints.MoviesPath + Categories.popular.rawValue + Constats.oldPathAPI + Constats.apiKey + "&language=\(language)&page=\(page)")
    }
    
// MARK: SETUP FUNC -
    
    func setupNavBarConfig() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.hidesBackButton = true
        self.title = "Popular"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let img = UIImage(systemName: "person.circle")
        let rightButton = UIBarButtonItem(image: img,
                                          style: UIBarButtonItem.Style.plain,
                                              target: self,
                                              action: #selector(self.rightNavBarItemAction))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupUI() {
        topSegmentCategories.setTitleTextAttributes([.foregroundColor: UIColor.systemGreen], for: .normal)
        topSegmentCategories.addTarget(self, action: #selector(segmentedControlAction), for: .valueChanged)
    }
    
    func setupCollection() {
        moviesCollection.register(UINib(nibName: MovieCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionCell.identifier)
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
    }
    
    func setupBottomSheet(titleAlert: String, messsage: String) {
        let actionSheet = UIAlertController(title: titleAlert, message: messsage, preferredStyle: .actionSheet)
        let seeProfile = UIAlertAction(title: "View Profile", style: .default) { action in
            self.presenter?.instantiateProfile(vc: self, sessionID: self.sessionID)
        }
        
        let logout = UIAlertAction(title: "Log out", style: .destructive) { action in
            print("DEBUG: LOGUT")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("DEBUG: CANCEL")
        }
        
        actionSheet.addAction(seeProfile)
        actionSheet.addAction(logout)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    
// MARK: @OBJC FUNC -
    @objc func segmentedControlAction(sender: UISegmentedControl) {
        arrayResults.removeAll()
        switch sender.selectedSegmentIndex {
        case 0:
            page = 1
            self.title = "Popular"
            presenter?.requestMovies(url: Endpoints.BaseURL + Endpoints.MoviesPath + Categories.popular.rawValue + Constats.oldPathAPI + Constats.apiKey + "&language=\(language)&page=\(page)")
        case 1:
            page = 1
            self.title = "Top Rated"
            presenter?.requestMovies(url: Endpoints.BaseURL + Endpoints.MoviesPath + Categories.topRated.rawValue + Constats.oldPathAPI + Constats.apiKey + "&language=\(language)&page=\(page)")
        case 2:
            page = 1
            self.title = "On TV"
            presenter?.requestMovies(url: Endpoints.BaseURL + Endpoints.MoviesPath + Categories.popular.rawValue + Constats.oldPathAPI + Constats.apiKey + "&language=\(language)&page=\(page)")
    
        default:
            page = 1
            self.title = "Airing Today"
            presenter?.requestMovies(url: Endpoints.BaseURL + Endpoints.MoviesPath + Categories.nowPlaying.rawValue + Constats.oldPathAPI + Constats.apiKey + "&language=\(language)&page=\(page)")
        }
    }
    
    @objc func rightNavBarItemAction() {
        setupBottomSheet(titleAlert: "What do you want to do", messsage: "")
    }

}

// MARK: EXTENSIONS -
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        
        if indexPath.item == arrayResults.count - 1 {
            page += 1
            presenter?.requestMovies(url: Endpoints.BaseURL + Endpoints.MoviesPath + Categories.popular.rawValue + Constats.oldPathAPI + Constats.apiKey + "&language=\(language)&page=\(page)")
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        moviesCollection.layoutIfNeeded()
        let width = moviesCollection.frame.width - 10
        let hight = (width / 2) + 140
        return CGSize(width: width / 2 , height: hight) //258
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.instantiateMovieDetail(vc: self, movieID: arrayResults[indexPath.item].id ?? 0)
    }
    
}

// MARK: EXTENSION -
extension HomeViewController: HomeViewProtocol {
    func successGetMovies(data: MoviesResponse) {
        guard let allResults = data.results else { return }
        allResults.forEach { item in
            arrayResults.append(item)
        }
        moviesCollection.reloadData()
    }
    
    func failGetMovies() {
        print("Fail get moview")
    }
}
