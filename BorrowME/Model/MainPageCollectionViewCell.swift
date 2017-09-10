//
//  MainPageCollectionViewCell.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/7.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit

class MainPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userPic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var borrowItem: UILabel!
    
    @IBOutlet weak var borrowTime: UILabel!
    
    @IBOutlet weak var itemDescription: UITextView!
    
    
    @IBOutlet weak var itemPic: UIImageView!
    
    @IBOutlet weak var chatButton: UIButton!
}
