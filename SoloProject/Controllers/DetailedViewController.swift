//
//  DetailedViewController.swift
//  SoloProject
//
//  Created by Ramu on 2/20/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit
import FirebaseStorage

class DetailedViewController: UIViewController {

    @IBOutlet weak var frameImage: UIImageView!
    @IBOutlet weak var frameBrand: UILabel!
    @IBOutlet weak var frameType: UILabel!
    @IBOutlet weak var frameShape: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var spectacleImage: UIImage!
    public var spectacle: Spectacle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let image = ImageCache.shared.fetchImageFromCache(urlString: spectacle.spectacleImageURL) {
            frameImage.image = image
            self.frameBrand.text = self.spectacle.spectacleBrand
            self.frameType.text = self.spectacle.spectacleType
            self.frameShape.text = self.spectacle.spectacleShape
        } else {
            ImageCache.shared.fetchImageFromNetwork(urlString: spectacle.spectacleImageURL) { (appError, image) in
                if let appError = appError {
                    self.showAlert(title: "Fetching Image Error", message: appError.errorMessage(), actionTitle: "Ok")
                } else if let image = image {
                    self.frameImage.image = image
                    
                }
            }
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        guard let imageData = frameImage.image?.jpegData(compressionQuality: 0.5) else {
            return
        }
        let favoriteSpectacle = FavoriteSpectacles.init(spectacleImage: imageData, spectacleBrand: frameBrand.text ?? "", spectacleShape: frameShape.text ?? "", spectacleType: frameType.text ?? "")
        
         let completion = SpectacleWatchListDataManager.saveToDocumentDirectory(newFavoriteSpectacle: favoriteSpectacle)
        if completion.success == true {
            showAlert(title: "Success!", message: "added to favorites", actionTitle: "OK")
        }
    }
    
        
    }
   


