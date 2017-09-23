//
//  pinCell.swift
//  pintrest-mock
//
//  Created by Abdullah Alhassan on 9/22/17.
//  Copyright © 2017 Abdullah Alhassan. All rights reserved.
//

import UIKit

class pinCell: UICollectionViewCell {
    
    var mainVC : MainVC?
    
    let SHADOW_COLOR = CGFloat(157/255)
    
    // create the image
    lazy var pinImage : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .blue
        img.layer.cornerRadius = 10
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.isUserInteractionEnabled = true
        img.layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        img.layer.shadowOpacity = 0.8
        img.layer.shadowRadius = 5.0
        img.layer.shadowOffset = CGSize(width: self.frame.width, height: self.frame.height)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImgTap))
        img.addGestureRecognizer(tap)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupCell()
    }
    
    @objc func handleImgTap(tapGesture: UITapGestureRecognizer) {
        if let img = tapGesture.view as? UIImageView {
            mainVC?.performZoom(startImage: img)
        }
    }
    
    func SetupCell() {
        addSubview(pinImage)
        // Image contraints
        pinImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        pinImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        pinImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        pinImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("decoder not init")
    }
}
