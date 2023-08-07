//
//  ViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 20.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onboardingShown = UserDefaults.standard.bool(forKey: "OnboardingViewController")
        if !onboardingShown {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            onboardingViewController.modalPresentationStyle = .fullScreen
           present(onboardingViewController, animated: true)
        }
        
        tableView.register(UINib(nibName: MovieListCell.className, bundle: nil), forCellReuseIdentifier: movieListIdentifier)
        
        DispatchQueue.main.async {
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator?.startAnimating()
        }

        Service().fetchMovieList { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.activityIndicator?.stopAnimating()
            }
            if !response.isEmpty {
                DispatchQueue.main.async {
                    self.movies = response
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                }
            }
        }
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 44))
        
        let titleLabel = UILabel(frame: titleView.bounds)
        titleLabel.text = "Trending Movies"
        titleLabel.textColor = UIColor(red: 0.94, green: 0.84, blue: 0.29, alpha: 1.00)
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .left
        titleView.addSubview(titleLabel)
        
        navigationItem.titleView = titleView
        navigationController?.navigationBar.tintColor = .white

        let customRightBarButton = UIBarButtonItem(title: "", image: UIImage(systemName: "bookmark"), target: self, action: #selector(favButtonTap))
        customRightBarButton.customView?.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 44, height: 44))
        customRightBarButton.tintColor = UIColor(red: 0.94, green: 0.84, blue: 0.29, alpha: 1.00)
        
        navigationItem.rightBarButtonItems = [customRightBarButton]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func favButtonTap() {
        let favoritesViewController = storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        self.navigationController?.pushViewController(favoritesViewController, animated: true)
    }
}

let movieListIdentifier = "movieListIdentifier"

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListIdentifier, for: indexPath) as! MovieListCell

        cell.bind(movie: movies[row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as! DetailsViewController
        
        detailsVC.movie = movies[row]
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate {}

extension NSObject {
    @objc public var className: String {
        return type(of: self).className
    }
    
    @objc public static var className: String {
        return String(describing: self)
    }
}


