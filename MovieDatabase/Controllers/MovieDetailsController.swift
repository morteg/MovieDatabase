//
//  MovieDetailsController.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import UIKit
import SDWebImage
import YouTubePlayer_Swift

class MovieDetailsController: UITableViewController {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    
    var headerView: UIView!
    private let kTableViewHeaderHeight: CGFloat = 150
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    var isOfflineMode = false
    var movie: Movie? {
        didSet {
            fillMovieInfo()
        }
    }
    
    var movieDetails: MovieDetails? {
        didSet {
            fillMovieDetails()
            loadTrailer()
        }
    }
    
    var trailers: [MovieVideo] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovieDetails()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: {[weak self]
            _ in
            self?.updateHeaderView()
            self?.tableView.reloadData()
        })
    }
    
    func setupUI() {
        headerView = tableView.tableHeaderView
        headerView.autoresizingMask = []
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableViewHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableViewHeaderHeight)
        updateHeaderView()
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let minimumHeight: CGFloat = 180
            let calculatedHeight = tableView.frame.height / 2.5
            return calculatedHeight > minimumHeight ? calculatedHeight : minimumHeight
        case 1:
            guard trailers.count > 0, !isOfflineMode else {return 0} //Trailers are disabled for offline mode
            return youtubePlayerView.frame.height
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    //MARK: - Misc
    func fillMovieInfo() {
        guard let movie = movie else {return}
        posterImageView.sd_setImage(with: movie.posterURL, placeholderImage: #imageLiteral(resourceName: "posterPlaceholder"), options: .scaleDownLargeImages, completed: nil)
        backdropImageView.sd_setImage(with: movie.backdropURL, completed: nil)
        titleLabel.text = movie.title
        releaseDateLabel.text = NSLocalizedString("Release date: ", comment: "") + ( movie.releaseDate != nil ? dateFormatter.string(from: movie.releaseDate!) : " - ")
        ratingLabel.text = NSLocalizedString("Rating: ", comment: "") + "\(String(format:"%.1f", movie.voteAvarage))\\10 (\(movie.voteCount))"
        overviewLabel.text = movie.overview
    }
    
    func fetchMovieDetails() {
        if isOfflineMode {
            fetchMovieDetailsOffline()
        } else {
            fetchMovieDetailsOffline()
        }
    }
    
    func fetchMovieDetailsOnline() {
        guard let movie = movie, movieDetails == nil else {return}
        ProgressView.shared.showProgressView(tableView, contentOffset: CGPoint(x: 0, y: -kTableViewHeaderHeight))
        NetworkManager.getMovieDetails(id: movie.id) { [weak self] error, movieDetails in
            guard let strongSelf = self else {return}
            ProgressView.shared.hideProgressView()
            if let error = error {
                strongSelf.showAlert(title: NSLocalizedString("Error!", comment: ""), message: error.localizedDescription, action: nil)
                return
            }
            strongSelf.movieDetails = movieDetails
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    func fetchMovieDetailsOffline() {
        guard let movie = movie, movieDetails == nil else {return}
        if let movieDetails = RealmManager.sharedInstance.getMovieDetails(id: movie.id) {
            self.movieDetails = movieDetails
            tableView.reloadData()
        }
    }
    
    func fillMovieDetails() {
        guard let movieDetails = movieDetails else {return}
        var countriesDescription = ""
        for country in movieDetails.productionCountries {
            countriesDescription = countriesDescription + " " + country.name                }
        countriesLabel.text = NSLocalizedString("Countries: ", comment: "") +  countriesDescription
        
        
        var genresDescription = ""
        for genre in movieDetails.genres {
            genresDescription = genresDescription + " " + genre.name
        }
        genresLabel.text = NSLocalizedString("Genres: ", comment: "") + genresDescription
        
        trailers = movieDetails.videos.filter({$0.videoType == .trailer})
        youtubePlayerView.isHidden = trailers.count == 0
        budgetLabel.text = "Budget: \(movieDetails.budget)$"
        revenueLabel.text = "Revenue: \(movieDetails.revenue)$"
    }
    
    //MARK: - Video playback
    func loadTrailer() {
        guard !isOfflineMode, let trailerVideo = movieDetails?.videos.first(where: {$0.videoType == .trailer}), !trailerVideo.key.isEmpty else {return}
        youtubePlayerView.loadVideoID(trailerVideo.key)
    }
    
    //MARK: - UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        guard headerView != nil else {return}
        var headerRect = CGRect(x: 0, y: -kTableViewHeaderHeight, width: tableView.bounds.width, height: kTableViewHeaderHeight)
        if tableView.contentOffset.y < -kTableViewHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
}


