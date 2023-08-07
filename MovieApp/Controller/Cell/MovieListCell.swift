//
//  MovieListCell.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 20.07.2023.
//

import UIKit
import SDWebImage

class MovieListCell: UITableViewCell {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var okButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(movie: Movie) {
        headerImageView.sd_setImage(with: URL(string: "\(baseImageUrl)\(movie.poster_path ?? "")"), placeholderImage: nil)
        titleLabel.text = movie.title
        
        let average = String(format: "%.1f", movie.vote_average ?? 0)
        
        infoLabel.text = "imdb: \(average)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
