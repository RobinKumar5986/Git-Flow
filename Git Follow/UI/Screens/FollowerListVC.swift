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
    var filteredFollowers: [Follower] = []
    var pageNumber: Int = 1
    var hasMoreFollower: Bool = true
    var isSerching: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(userName: userName,page: pageNumber)
        configureDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func configureCollectionView(){
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UiHelper.createThreeColoumFlowLayout(in: view)
        )
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self,forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFollowers(userName: String, page: Int = 1){
        showLoadingView()
        NetworkManager.shared.getFollowers(
            for: userName,
            page: page,
            completion: { [weak self] result in
                guard let self = self else {return}
                self.dismissLodingView()
                switch(result){
                case .failure(let error):
                    self.presentGFAlertOnMainThread(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                case .success(let followers):
                    print("Success: Data fetched successfully")
                    if followers.count < 100 { hasMoreFollower = false }
                    self.followers.append(contentsOf: followers)
                    self.updateData(on: self.followers)
                    if(self.followers.isEmpty) {
                        DispatchQueue.main.async {
                            let message = "This user dosn't have any Followers. Go Follow them 😊"
                            self.showEmptyStateView(with: message,in: self.view)
                        }
                    }
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
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for username"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false //this can be used for remoing the slight background becomming dark.
        
    }
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot,animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if(offsetY > contentHeight - height){
            guard hasMoreFollower else { return }
            pageNumber += 1
            getFollowers(userName: userName,page: pageNumber)
        }
    }
    func collectionView( _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath ) {
        var follower: Follower = isSerching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        let destVC = UserInfoVC()
        destVC.userName = follower.login
        
        let navigationController = UINavigationController(rootViewController: destVC)
        present(navigationController,animated: true)
    }
    
}


extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            isSerching = false
            return
        }
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
        isSerching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSerching = false
    }
}
