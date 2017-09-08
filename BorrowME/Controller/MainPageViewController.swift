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
        let cell: MainPageCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "coCell", for:indexPath ) as? MainPageCollectionViewCell
        cell?.labelTest.text = "whaaaaatttt"
        
        cell?.layer.cornerRadius = 8
        cell?.layer.masksToBounds = true
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor = UIColor(red: 0.196, green: 0.149, blue: 0.416, alpha: 1)
        self.view.backgroundColor = myColor
        UIApplication.shared.statusBarStyle = .lightContent
        //self.mainPageCollectionView.delegate = self
        self.mainPageCollectionView.dataSource = self
        
        let transparentColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        self.mainPageCollectionView.backgroundColor = transparentColor
        
        // Do any additional setup after loading the view.
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.mainPageCollectionView.frame.width,height: 125)//self.mainPageCollectionView.frame.height/4.5)
        mainPageCollectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showBorrowPage(_ sender: Any) {
        performSegue(withIdentifier: "toBorrowPage", sender: nil)
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
