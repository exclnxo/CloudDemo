//
//  PhotoViewController.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import UIKit
import Moya

class PhotoViewController: UIViewController {

    var activityIndicator = UIActivityIndicatorView()
    var collectionView: UICollectionView?
    var photos: [photoModel]?
    let provider = MoyaProvider<photoService>()
    let imageCache = NSCache<NSURL, UIImage>()
    let viewModel = PhotosViewModel(apiService: ApiService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        
        self.bindViewModel()
    }
    
    func initUI() {
        let layout = UICollectionViewFlowLayout()
        let w = self.view.bounds.width / 4
        layout.itemSize = CGSize(width: w, height: w)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        
        view.addSubview(collectionView!)
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .systemBlue
        activityIndicator.style = .whiteLarge
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
        ])
        activityIndicator.startAnimating()
    }
    
    func bindViewModel() {
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
    }
}

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        
        let photo = viewModel.getCellViewModel(indexPath)
        cell?.idLabel.text = String(photo.id ?? 0)
        cell?.urlLabel.text = photo.title
        if let url = photo.thumbnailUrl {
            cell?.activityIndicator.startAnimating()
            cell?.activityIndicator.isHidden = false
            let URL = NSURL.init(string: url)!
            if let image = imageCache.object(forKey: URL as NSURL) {
                cell?.iv.image = image
                cell?.activityIndicator.stopAnimating()
                cell?.activityIndicator.isHidden = true
            } else {
                provider.request(photoService.downloadImage(url: url)) { (result) in
                    switch result {
                    case let .success(response):
                        if let image = UIImage(data: response.data) {
                            self.imageCache.setObject(image, forKey: URL as NSURL)
                            cell?.iv.image = image
                            cell?.activityIndicator.stopAnimating()
                            cell?.activityIndicator.isHidden = true
                        }
                    case .failure(_): break
                        
                    }
                }
            }
            
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    
}
