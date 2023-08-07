//
//  DetailsVC.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 21.07.2023.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var imageCoverPhoto: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    var selectedMovie: String = ""
    
    @IBOutlet weak var labelNames: UILabel!
    @IBOutlet weak var labelPoint: UILabel!
    @IBOutlet weak var imageHearth: UIImageView!
    @IBOutlet weak var labelShortsTitle: UILabel!
    @IBOutlet weak var labelParagraph: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        printContent("abc")
        // Örneğin, seçilen filmin adını ekranda göstermek gibi.
    }
}
