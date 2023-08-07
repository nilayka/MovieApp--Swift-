//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 24.07.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favTableView: UITableView!
    
    var array: [String] = []
    var defaults = UserDefaults.standard
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTableView.register(UINib(nibName: MovieListCell.className, bundle: nil), forCellReuseIdentifier: movieListIdentifier)
            
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        let titleLabel = UILabel(frame: titleView.bounds)
        
        titleLabel.text = "My Favorites"
        titleLabel.textColor = UIColor(red: 0.94, green: 0.84, blue: 0.29, alpha: 1.00)
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        navigationItem.titleView = titleView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let defaultFavoriteList = (defaults.object(forKey: "favoriteList") as? Data),  let favoriteList = try? JSONDecoder().decode([Movie].self, from: defaultFavoriteList) {
            
            if !favoriteList.isEmpty {
                DispatchQueue.main.async {
                    self.movies = favoriteList
                    self.favTableView.dataSource = self
                    self.favTableView.delegate = self
                    self.favTableView.reloadData()
                }
            }

        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: movieListIdentifier, for: indexPath) as! MovieListCell
        
        cell.bind(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsViewController
        
        viewController?.movie = movies[indexPath.row]
        
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movies.remove(at: indexPath.row)

            let encoder = JSONEncoder()
            
            if let encodedData = try? encoder.encode(movies) {
                defaults.set(encodedData, forKey: "favoriteList")
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
