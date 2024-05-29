//
//  GaleryViewController.swift
//  RabbitFlowers
//
//  Created by Виктория Бони on 27.05.2024.
//

import UIKit
import Kingfisher

class GaleryViewController: UIViewController {
    
    @IBOutlet weak var imageMain: UIImageView!
    
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
        loadImage()
    }
    
    func toolBarSetup() {
        
        var arrayButton = [UIBarButtonItem]()
        
        let sharedButton = createCustomButton(imageName: "square.and.arrow.up.fill", target: self, action: #selector(sharedButtonTap), touchDownAction: #selector(buttonTouchDown(_:)), touchUpAction: #selector(buttonTouchUp(_:)))
        let backImageButton = createCustomButton(imageName: "arrow.left.square.fill", target: self, action: #selector(nextImageTap), touchDownAction: #selector(buttonTouchDown(_:)), touchUpAction: #selector(buttonTouchUp(_:)))
        let playSliderButton = createCustomButton(imageName: "play.rectangle.fill", target: self, action: #selector(playSliderTap), touchDownAction: #selector(buttonTouchDown(_:)), touchUpAction: #selector(buttonTouchUp(_:)))
        let nextImageButton = createCustomButton(imageName: "arrow.right.square.fill", target: self, action: #selector(lastImageTap), touchDownAction: #selector(buttonTouchDown(_:)), touchUpAction: #selector(buttonTouchUp(_:)))
        
        arrayButton.append(sharedButton)
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        arrayButton.append(backImageButton)
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        arrayButton.append(playSliderButton)
        arrayButton.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        arrayButton.append(nextImageButton)
        
        let apperance = UIToolbarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .systemGray6
        
        navigationController?.toolbar.standardAppearance = apperance
        if #available(iOS 15.0, *) {
            navigationController?.toolbar.scrollEdgeAppearance = apperance
        } else {
            // ???
        }
        navigationController?.toolbar.compactAppearance = apperance
        
        navigationController?.toolbar.tintColor = .lightGray
        
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
            imageMain.kf.setImage(with: url)
            
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
    
    @IBAction func gestureLeftOrRight(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        
        if sender.state == .ended {
            if translation.x > 0 {
                nextImage()
            } else if translation.x < 0 {
               backImage()
            }
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
    
    @objc func buttonTouchDown(_ sender: UIButton) {
        sender.tintColor = allColorsPattern.baseColor
    }
    
    @objc func buttonTouchUp(_ sender: UIButton) {
        sender.tintColor = .lightGray
    }
    
    
    
}



