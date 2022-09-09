//
//  MovieDetailViewController.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
// MARK: PROTOCOL VAR -
    var presenter: MovieDetailPresenterProtocol?
    
// MARK: PROPERTIES -
    var movieID = 0
    let loader = LoaderViewController.showLoader()
    
// MARK: @IBOUTLTETS -
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var firstContentView: UIView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    
// MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.present(loader, animated: false)
        presenter?.requestMovieDetail(url: Endpoints.BaseURL + Endpoints.MoviesPath + "\(movieID)" + Constats.oldPathAPI + Constats.apiKey)

    }
    
// MARK: SETUP FUNC -
    func setupAlertError(alrtTitle: String, message: String) {
        let alert = UIAlertController(title: alrtTitle, message: message, preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try again", style: .default) { action in
            self.presenter?.requestMovieDetail(url: Endpoints.BaseURL + Endpoints.MoviesPath + "\(self.movieID)" + Constats.oldPathAPI + Constats.apiKey)
        }
        alert.addAction(tryAgain)
        self.present(alert, animated: true)
    }
    
// MARK: GENERAL FUNC -
    func fillData(data: MovieDetailResponse) {
        imgMovie.DownloadImgFromURL(uri: Endpoints.ImagePath + (data.poster_path ?? ""))
        lblMovieName.text = data.title
        lblDate.text = data.release_date
        lblRating.text = "★ \(data.vote_average ?? 0.0)"
        lblDescription.text = "Overview:\n\(data.overview ?? "")"
        var arrayGenres = [String]()
        data.genres?.forEach({ item in
            arrayGenres.append(item.name ?? "")
        })
        lblGenres.text = "Genero:  \(arrayGenres.joined(separator: ", "))"
        
    }
}
 //★

// MARK: EXTENSION -
extension MovieDetailViewController: MovieDetailViewProtocol {
    func successGetMovieDetail(data: MovieDetailResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loader.dismiss(animated: false)
            self.fillData(data: data)
        }
        
    }
    
    func failGetMovieDetail() {
        setupAlertError(alrtTitle: "We´re sorry", message: "Somethings, wrong, please try again")
    }
}
