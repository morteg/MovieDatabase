//
//  MoviesCollectionControllerswift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import UIKit

class MoviesCollectionController: UIViewController {
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet weak var dataModeBarButton: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchIsActive: Bool {
        return searchController.searchBar.text != ""
    }
    fileprivate var pendingRequestWorkItem: DispatchWorkItem?
    
    var movies: [Movie] = []
    var currentPage = 0
    var isAllPagesLoaded = false
    
    var isOfflineMode = false {
        didSet {
            updateMoviesData()
        }
    }
    private let movieCellIdentifer = "MoviesCollectionCell"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getMovies()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        moviesCollection.collectionViewLayout.invalidateLayout()
    }
    
    func setupUI() {
        let moviesCellNib = UINib(nibName: "MoviesCollectionCell", bundle: .main)
        moviesCollection.register(moviesCellNib, forCellWithReuseIdentifier: movieCellIdentifer)
        moviesCollection.setCollectionViewLayout(CollectionGridFlowLayout(), animated: false)
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search for movies", comment: "")
        
        self.navigationItem.titleView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    //MARK: - Misc
    func updateMoviesData() {
        currentPage = 0
        isAllPagesLoaded = false
        movies.removeAll()
        getMovies()
        moviesCollection.reloadData()
    }
    
    func getMoviesOnline() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let searchText = searchController.searchBar.text ?? ""
        let nextPage = currentPage + 1
        let defaultRequestCompletion :  (Error?, [Movie], Int) -> () = {
            [weak self] error, movies, totalPages in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let strongSelf = self else {return}
            if let error = error {
                strongSelf.showAlert(title: NSLocalizedString("Error!", comment: ""), message: error.localizedDescription, action: nil)
                return
            }
            strongSelf.currentPage = nextPage
            if totalPages == nextPage {
                strongSelf.isAllPagesLoaded = true
            }
            
            guard movies.count > 0 else {return}
            strongSelf.movies.append(contentsOf: movies)
            DispatchQueue.main.async {
                strongSelf.moviesCollection.performBatchUpdates({
                    strongSelf.moviesCollection.reloadSections([0])
                }, completion: nil)
            }
        }
        
        if searchIsActive {
            NetworkManager.searchMovie(searchString: searchText, page: nextPage, completion: defaultRequestCompletion)
        } else {
            NetworkManager.getNewMovies(page: nextPage, completion: defaultRequestCompletion)
        }
    }
    
    func getMoviesOffline() {
        let searchText = searchController.searchBar.text ?? ""
        let realmMovies = RealmManager.sharedInstance.getNewMovies(searchText: searchText)
        movies.append(contentsOf: realmMovies)
        DispatchQueue.main.async { [weak self] in
            self?.moviesCollection.performBatchUpdates({
            self?.moviesCollection.reloadSections([0])
            }, completion: nil)
        }
    }
    
    func getMovies() {
        if isOfflineMode {
            getMoviesOffline()
        } else {
            getMoviesOnline()
        }
    }
    
    //MARK: - Actions
    @IBAction func dataModeButtonClicked(_ sender: Any) {
        isOfflineMode = !isOfflineMode
        dataModeBarButton.title = isOfflineMode ? NSLocalizedString("Offline", comment: "") : NSLocalizedString("Online", comment: "")
    }

}


//MARK: - UICollectionViewDataSource
extension MoviesCollectionController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifer, for: indexPath) as! MoviesCollectionCell
        cell.movie = movies[indexPath.row]
        
        if !isOfflineMode && indexPath.row == self.movies.count - 1 && !isAllPagesLoaded {
            getMovies()
        }
        return cell
    }
}

//MARK: - UICollectionViewDataSource
extension MoviesCollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: .main)
        guard let movieDetailsController = storyboard.instantiateInitialViewController() as? MovieDetailsController else {return}
        _ = movieDetailsController.view
        let movie = movies[indexPath.row]
        movieDetailsController.isOfflineMode = isOfflineMode
        movieDetailsController.movie = movies[indexPath.row]
        movieDetailsController.title = movie.title
        navigationController?.pushViewController(movieDetailsController, animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension MoviesCollectionController: UISearchResultsUpdating {
    func filterContentForSearchText() {
        
        pendingRequestWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.getMovies()
        }
        
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        currentPage = 0
        isAllPagesLoaded  = false
        movies.removeAll()
        moviesCollection.reloadData()
        filterContentForSearchText()
    }
}
