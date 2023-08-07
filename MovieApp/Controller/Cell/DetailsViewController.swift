//
//  DetailsVC.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 23.07.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieSubTitle: UILabel!
    var movie: Movie?
    var defaults = UserDefaults.standard
    
    var isHeartFilled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isHeartFilled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isHeartFilled")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TapGesture()
        bind()
        heartImageView.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
        setFillHeartImage()
        
    }
    
    func bind() {
        movieTitleLabel.text = movie?.title
        descriptionLabel.text = movie?.overview
        movieImageView.sd_setImage(with: URL(string: "\(baseImageUrl)\(movie?.poster_path ?? "")"), placeholderImage: nil)
        movieSubTitle.text = movie?.release_date
        let average = String(format: "%.1f", movie?.vote_average ?? 0)
        voteLabel.text = "imdb: \(average)"
        
        guard let defaultsFavorite = (self.defaults.object(forKey: "favoriteList") as? Data),
              let favoriteList = try? JSONDecoder().decode([Movie].self, from: defaultsFavorite) else { return }
        
        self.isHeartFilled = (favoriteList.first(where: { $0.id == self.movie?.id}) != nil)
    }
    
    private func TapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartImageViewTapped))
        heartImageView.addGestureRecognizer(tapGesture)
        heartImageView.isUserInteractionEnabled = true
    }
    
    @objc private func heartImageViewTapped() {
        UIView.animate(withDuration: 0.2, animations: {
            self.heartImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            
                self.setFavorite(movie: self.movie)

            UIView.animate(withDuration: 0.2) {
                self.heartImageView.transform = .identity
            }
        }
    }
    
    func setFavorite(movie: Movie?) {
        
        if let defaultFavoriteList = (defaults.object(forKey: "favoriteList") as? Data),  let favoriteList = try? JSONDecoder().decode([Movie].self, from: defaultFavoriteList){
            
            if !favoriteList.isEmpty {
                if isHeartFilled {
                    var newFavoriteList = favoriteList
                    if let movie = self.movie {
                        newFavoriteList.removeAll(where: { $0.id == movie.id})
                        self.defaults.set(try? JSONEncoder().encode(newFavoriteList), forKey: "favoriteList")
                        heartImageView.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
                        isHeartFilled = false
                    }
                } else {
                    var newFavoriteList = favoriteList
                    if let movie = self.movie {
                        newFavoriteList.append(movie)
                    }
                    self.defaults.set(try? JSONEncoder().encode(newFavoriteList), forKey: "favoriteList")
                    heartImageView.image = UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal)
                    isHeartFilled = true
                }
            } else {
                self.defaults.set(try? JSONEncoder().encode([movie]), forKey: "favoriteList")
                heartImageView.image = UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal)
                isHeartFilled = true
            }

        } else {
            self.defaults.set(try? JSONEncoder().encode([movie]), forKey: "favoriteList")
            heartImageView.image = UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal)
            isHeartFilled = true
        }
    }
    
    private func changeHeartImage() {
        if isHeartFilled {
            heartImageView.image = UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal)
        } else {
            heartImageView.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
        }
    }
    func setFillHeartImage() {
        if let defaultFavoriteList = (defaults.object(forKey: "favoriteList") as? Data),  let favoriteList = try? JSONDecoder().decode([Movie].self, from: defaultFavoriteList){
            
            if !favoriteList.isEmpty {
                for favoriMovie in favoriteList {
                    if favoriMovie.id == self.movie?.id {
                        heartImageView.image = UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal)
                        isHeartFilled = true
                    }
                }
            } else {
                heartImageView.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
                isHeartFilled = false
            }

        } else {
            heartImageView.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
            isHeartFilled = false
        }
    }
}
