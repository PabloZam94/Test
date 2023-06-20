//
//  ProductInfoViewController.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

class ProductInfoViewController: UIViewController {
    
// MARK: PROTOCOL VAR -
    var presenter: ProductInfoPresenterProtocol?
    
// MARK: PROPERTIES -
    var movieID = 0
    var itemId = ""
    let loader = LoaderViewController.showLoader()
    var products = [ProductInfoModel]()
    
// MARK: @IBOUTLTETS -

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgSection: UIView!
    @IBOutlet weak var collectionProductImages: UICollectionView!
    @IBOutlet weak var subContentView: UIView!
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTaxes: UILabel!
    @IBOutlet weak var lblBottomTaxes: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    // MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(self.loader, animated: false)
        }
        presenter?.callRequestProductInfo(itemIds: itemId)
        setupUI()
        confingCollection()
    }
    
// MARK: SETUP FUNC -
    func setupUI() {
        subContentView.layer.cornerRadius = 20
        gradientView.setGrdientVertical(colors: [UIColor.clear.cgColor, UIColor.black.cgColor])
    }
    
    func setupAlertError(alrtTitle: String, message: String) {
        let alert = UIAlertController(title: alrtTitle, message: message, preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try again", style: .default) { action in
            //self.presenter?.requestMovieDetail(url: Endpoints.BaseURL + Endpoints.MoviesPath + "\(self.movieID)" + Constats.oldPathAPI + Constats.apiKey)
        }
        alert.addAction(tryAgain)
        self.present(alert, animated: true)
    }
    
// MARK: GENERAL FUNC -
    func fillData(data: [ProductInfoModel]) {
        let product = data.first?.body
        products = data
        lblNAme.text = product?.title
        lblPrice.text = product?.price?.currencyFormat()
        lblTaxes.alpha = product?.acceptsMercadopago ?? false ? 1 : 0
        lblBottomTaxes.text = "Disponible (\(product?.availableQuantity ?? 0))"
        collectionProductImages.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loader.dismiss(animated: false)
        }
    }
    
    func confingCollection() {
        collectionProductImages.register(UINib(nibName: ProductImgCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductImgCell.identifier)
        collectionProductImages.delegate = self
        collectionProductImages.dataSource = self
    }
    
// MARK: @IBACTIONS -
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: EXTENSION -
extension ProductInfoViewController: ProductInfoViewProtocol {
//    func successGetMovieDetail(data: MovieDetailResponse) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.loader.dismiss(animated: false)
//        }
//    }
//    
//    func failGetMovieDetail() {
//        setupAlertError(alrtTitle: "We´re sorry", message: "Somethings, wrong, please try again")
//    }
//
    func successGetProductInfo(data: [ProductInfoModel]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fillData(data: data)
        }
    }
    
    func failureGetProductInfo(error: RequestError) {
        print(error)
    }
}

extension ProductInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.first?.body?.pictures?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImgCell.identifier, for: indexPath) as? ProductImgCell else { return UICollectionViewCell() }
        let imgUrl = products.first?.body?.pictures?[indexPath.item].url ?? ""
        cell.setContent(imgUrl: imgUrl)
        return cell
    }
}

extension ProductInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionProductImages.layoutIfNeeded()
        return CGSize(width: collectionProductImages.frame.width, height: collectionProductImages.frame.height)
    }
}
