//
//  MainPageViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/7.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var mainPageCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainPageCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "coCell", for:indexPath ) as! MainPageCollectionViewCell
        cell?.labelTest.text = "whaaaaatttt"
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mainPageCollectionView.delegate = self
        self.mainPageCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.mainPageCollectionView.frame.width,height: self.mainPageCollectionView.frame.height/4.5)
        mainPageCollectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
