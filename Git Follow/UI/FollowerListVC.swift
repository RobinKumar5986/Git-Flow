//
//  FollowerListVC.swift
//  Git Follow
//
//  Created by iOS Dev on 16/12/25.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func configureCollectionView(){
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createThreeColoumFlowLayout()
        )
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self,forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createThreeColoumFlowLayout() -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(
            for: userName,
            page: 1,
            completion: { result in
                switch(result){
                case .failure(let error):
                    self.presentGFAlertOnMainThread(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                case .success(let followers):
                    print("Success: Data fetched successfully")
                    self.followers = followers
                    self.updateData()
                }
            }
        )
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView
        ) { collectionView, indexPath, follower in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        }
    }
    
    func updateData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot,animatingDifferences: true)
        }
    }
}
