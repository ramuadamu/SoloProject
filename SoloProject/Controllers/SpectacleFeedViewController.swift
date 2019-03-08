//
//  ViewController.swift
//  SoloProject
//
//  Created by Ramu on 2/14/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit
import Photos
import FirebaseFirestore


class SpectacleFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var spectacles = [Spectacle]() {
        didSet {
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    private var eyeGlass: Spectacle!
    private var listener: ListenerRegistration!
    private var imagePickerViewController: UIImagePickerController!
    var spectacleImage: UIImage!
    var storageManager: StorageManager!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
        fetchSpectacles()
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSpectacles()
    }
    
    @objc func setupSpectacleImage() {
        imagePickerViewController = UIImagePickerController()
     imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        }
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    @objc func setImageAlertController() {
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (alert: UIAlertAction) in self.setupSpectacleImage()
        }
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alert: UIAlertAction) in
            self.setupSpectacleImage()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction) in
            self.setupSpectacleImage()
        }
    }
    
    private func fetchSpectacles() {
        listener = DatabaseManager.firebaseDB.collection(DatabaseKeys.FrameCollectionKey).addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
            if let error = error {
                self.showAlert(title: "Network Error", message: error.localizedDescription, actionTitle: "Ok")
            } else if let snapshot = snapshot {
                var spectacles = [Spectacle]()
                for document in snapshot.documents {
                    let spectacle = Spectacle(dict: document.data())
                    spectacles.append(spectacle)
                }
                self.spectacles = spectacles
            }
        })
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let addSpectacleVC = storyBoard.instantiateViewController(withIdentifier: "AddSpectacleViewController") as! AddSpectacleViewController
        let nav = UINavigationController.init(rootViewController: addSpectacleVC)
        present(nav, animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailedViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                return
        }
        let spectacle = spectacles[indexPath.row]
         dest.spectacle = spectacle
        }
    }
extension SpectacleFeedViewController: UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        spectacleImage = originalImage
        guard let imageData = spectacleImage.jpegData(compressionQuality: 0.5) else {
            showAlert(title: "Error", message: "Try Again", actionTitle: "Ok")
            return
        }
        //storageManager.postImage(withData: imageData)
        self.tableView.reloadData()
        dismiss(animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spectacles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "spectacleCell", for: indexPath) as? SpectacleTableViewCell else {
            return UITableViewCell()
        }
        
        
        let spectacle = spectacles[indexPath.row]
        if let image = ImageCache.shared.fetchImageFromCache(urlString: spectacle.spectacleImageURL) {
            cell.spectacleImage.image = image
        } else {
            ImageCache.shared.fetchImageFromNetwork(urlString: spectacle.spectacleImageURL) { (appError, image) in
                if let appError = appError {
                    if cell.spectacleImage.image == nil {
                    self.showAlert(title: "Fetching Image Error", message: appError.errorMessage(), actionTitle: "Ok")
                    }
                } else if let image = image {
                    cell.spectacleImage.image = image
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension SpectacleFeedViewController: StorageManagerDelegate {
    func didFetchImage(_ storageManager: StorageManager, imageURL: URL) {
        
    }
}


