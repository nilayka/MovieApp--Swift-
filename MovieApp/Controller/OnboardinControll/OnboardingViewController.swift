//
//  OnboardingViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 1.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var controlButton: UIButton!
    
    var imageIndex = 0
    @IBAction func pageValueChanged(_ sender: UIButton) {
        showItem(at: pageControl.currentPage)
    }
    
    @IBAction func controlButton(_ sender: Any) {
        imageIndex += 1
        
        if imageIndex >= imageArray.count {
            UserDefaults.standard.setValue(true, forKey: "OnboardingViewController")
            UserDefaults.standard.synchronize() //key e ait değeri setliyo
            self.dismiss(animated: true)
        } else {
            let indexPath = IndexPath(item: imageIndex, section: 0)
            
            self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
            
            pageControl.currentPage = imageIndex
        }
    }
    
    let descriptionArray = [
        "Welcome To \n MovieApp",
        "You can easily access content \n about trending \n movies",
        "Create your own favorite movie list"
    ]
    
    let imageArray = [
        ImageHelper.image1,
        ImageHelper.image2,
        ImageHelper.image3,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.isScrollEnabled = true
        
        pageControl.page = 0
    }
    
    private func showItem(at index: Int) {
        pageControl.page = index
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCell", for: indexPath) as! OnboardingCell
        
        cell.artImageConstraints.constant = normalize(value: 260.0)
        cell.artImage.image = imageArray[indexPath.row]
        cell.descriptionLabel.text = descriptionArray[indexPath.row]
        
        if indexPath.row == 0 {
            cell.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
            cell.descriptionLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 380.0).isActive = true
        }
        if indexPath.row == 1 {
            cell.descriptionLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 345.0).isActive = true
        }
        
        if indexPath.row == 2 {
            cell.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 33.0)
            cell.descriptionLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 375.0).isActive = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        
        pageControl.page = page
    }
}

extension UIPageControl {
    var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
            
            for index in 0..<numberOfPages where index != newValue {
                setIndicatorImage(ImageHelper.page, forPage: index)
            }
            
            setIndicatorImage(ImageHelper.pageSelected, forPage: newValue)
        }
    }
    
}

func normalize(value: CGFloat) -> CGFloat {
    let scale = UIScreen.main.bounds.width / 375.0
    return value * scale
}
