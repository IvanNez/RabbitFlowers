    //
//  GaleryViewController.swift
//  RabbitFlowers
//
//  Created by Виктория Бони on 27.05.2024.
//

import UIKit
import Kingfisher

class GaleryViewController: UIViewController {


    
    
    let galeryModel = GaleryModel()
    var counterImage = 0
    var isPlaySliderShow = false
    var tInterval = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }

    func setup() {
        toolBarSetup()
    }
    
    func toolBarSetup() {
        
        var arrayButton = [UIBarButtonItem]()
        
        
        arrayButton.append(UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up.fill"), style: .plain, target: self, action: #selector(sharedButtonTap)))
        
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        arrayButton.append(UIBarButtonItem(image: UIImage(systemName: "backward.fill"), style: .plain, target: self, action: #selector(lastImageTap)))
        
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        arrayButton.append(UIBarButtonItem(image: UIImage(systemName: "play.rectangle.fill"), style: .plain, target: self, action: #selector(playSliderTap)))
        
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        arrayButton.append(UIBarButtonItem(image: UIImage(systemName: "forward.fill"), style: .plain, target: self, action: #selector(nextImageTap)))
       
        
        let apperance = UIToolbarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .systemGray6
       
        navigationController?.toolbar.standardAppearance = apperance
        if #available(iOS 15.0, *) {
            navigationController?.toolbar.scrollEdgeAppearance = apperance
        } else {
            // Fallback on earlier versions
        }
        navigationController?.toolbar.compactAppearance = apperance
        
        navigationController?.toolbar.tintColor = .black
       
        self.toolbarItems = arrayButton
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func loadImage() {
        galeryModel.downloadImage { result in
            if result {
                DispatchQueue.main.async {
                    self.nextImage()
                }
            }
            else {
                DispatchQueue.main.async {
                    Alerts.shared.alertDialog(presenter: self, title: "Ошибка", description: "Ошибка загрузки изображения")
                }
            }
        }
    }
    
    func nextImage () {
        guard galeryModel.images.isEmpty == false else { return }
        if galeryModel.images.indices.contains(counterImage + 1){
            counterImage += 1
            guard let url = URL(string: galeryModel.images[counterImage].url) else { return }
            imageMain.kf.setImage(with: url, placeholder: UIImage(systemName: "folder.fill"))
                    
        } else {
            counterImage = 0
            guard let url = URL(string: galeryModel.images[counterImage].url) else { return }
            imageMain.kf.setImage(with: url)
        }
    }
    
    func backImage() {
        guard galeryModel.images.isEmpty == false else { return }
        if galeryModel.images.indices.contains(counterImage - 1){
            counterImage -= 1
            guard let url = URL(string: galeryModel.images[counterImage].url) else { return }
            imageMain.kf.setImage(with: url)
                    
        } else {
            counterImage = galeryModel.images.count - 1
            guard let url = URL(string: galeryModel.images[counterImage].url) else { return }
            imageMain.kf.setImage(with: url)
        }
    }
}


// MARK: -- OBJC
extension GaleryViewController {
    @objc func sharedButtonTap() {
        guard let image = imageMain.image else { return }
        let shareImage = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareImage, animated: true)
    }
    
    @objc func lastImageTap() {
        backImage()
    }
    
    @objc func playSliderTap() {
        isPlaySliderShow.toggle()
        Timer.scheduledTimer(withTimeInterval: tInterval , repeats: true) { [self] tmr in
            if isPlaySliderShow {
                nextImage()
            } else {
                tmr.invalidate()
            }
        }
    }
    
    @objc func nextImageTap() {
        nextImage()
    }
}

// MARK: -- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension GaleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 392, height: 392)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: collectionView.bounds.height / 5, left: 0, bottom: 0, right: 0)
    }
}


