//
//  FavoritesListVC.swift
//  Git Follow
//
//  Created by iOS Dev on 11/12/25.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    func loadFavorites(){
        PersistenceManager.retriveFavorites() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favoritesList):
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "Ok"
                )
            }
        }
    }
}
