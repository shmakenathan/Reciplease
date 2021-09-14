//
//  BaseViewController.swift
//  Reciplease
//
//  Created by Nathan on 29/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
   
    
    func changeLoadingIndicatorVisibility(shouldShow: Bool) {
        if shouldShow {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
    }
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    private func setupLoadingIndicator() {
        activityIndicatorView = UIActivityIndicatorView()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.color = .white
    }
}
