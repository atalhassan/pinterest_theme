//
//  MainVC.swift
//  pintrest-mock
//
//  Created by Abdullah Alhassan on 9/22/17.
//  Copyright © 2017 Abdullah Alhassan. All rights reserved.
//

import UIKit

class MainVC: UICollectionViewController, CustomLayoutDelegate {

    // collection cell id
    let cellid = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation
        navigationItem.title = "Pintrest"
        navigationItem.largeTitleDisplayMode = .always
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // setup CollectionView
        collectionView?.backgroundColor = .white
        collectionView?.register(pinCell.self, forCellWithReuseIdentifier: cellid)
        
        collectionView?.showsVerticalScrollIndicator = false
        if let layout = collectionView?.collectionViewLayout as? customLayout {
            layout.delegate = self
        }
        
    }
    
    // ============================
    // collectionView protocols
    // ============================
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? pinCell {
            cell.backgroundColor = .white
            cell.mainVC = self
            cell.pinImage.image = UIImage(named: "\(indexPath.row + 1)")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let img = UIImage(named: "\(indexPath.row + 1)")
        let height = img?.size.height
        return height!
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let layout = collectionView?.collectionViewLayout as? customLayout {
            layout.invalidateLayout()
        }
    }
    
    // ============================
    // Handle image zoom in/out
    // ============================
    var startFrame : CGRect?
    var blackVC : UIView?
    var startingImage : UIImageView?
    
    func performZoom(startImage: UIImageView) {
        self.startingImage = startImage
        startFrame = startImage.superview?.convert(startImage.frame, to: nil)
        let zoomedImg = UIImageView(frame: startFrame!)
        zoomedImg.contentMode = .scaleAspectFill
        zoomedImg.image = startImage.image
        zoomedImg.isUserInteractionEnabled = true
        zoomedImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performZoomOut)))
        startImage.isHidden = true
        
        if let keyWindow = UIApplication.shared.keyWindow {
            self.blackVC = UIView(frame: keyWindow.frame)
            self.blackVC?.backgroundColor = .black
            self.blackVC?.alpha = 0
            keyWindow.addSubview(self.blackVC!)
            keyWindow.addSubview(zoomedImg)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackVC?.alpha = 1
                let height = (self.startFrame?.height)! / (self.startFrame?.width)! * keyWindow.frame.width
                zoomedImg.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomedImg.center = keyWindow.center
            }, completion:{ (success) in
                
            })
        }
        
    }
    
    @objc func performZoomOut(tapGestur: UITapGestureRecognizer){
        if let zoomOutImage = tapGestur.view as? UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImage.layer.cornerRadius = 10
                zoomOutImage.clipsToBounds = true
                zoomOutImage.frame = self.startFrame!
                self.blackVC?.alpha = 0
            }, completion: { (success) in
                zoomOutImage.removeFromSuperview()
                self.startingImage?.isHidden = false
            })
        }
    }
    
}













