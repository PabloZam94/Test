//
//  LoaderViewController.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 09/09/22.
//

import UIKit

class LoaderViewController: UIViewController {

// MARK: @IBOUTLETS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var lblLoading: UILabel!
    
// MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
// MARK: SETUP FUNC -
    func setupUI() {
        loader.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.shadowView.alpha = 0.7
            self.loader.alpha = 1
            self.lblLoading.alpha = 1
        }
    }
    
//MARK: - Inicialización
    class func showLoader() -> LoaderViewController {
        let storyboard = UIStoryboard(name: "Loader", bundle: Bundle(for: LoaderViewController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "LoaderViewController") as! LoaderViewController
        view.modalPresentationStyle = .overFullScreen
        
        return view
    }
    
}
