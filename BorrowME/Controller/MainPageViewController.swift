//
//  MainPageViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/7.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var mainPageCollectionView: UICollectionView!
    var downloadData:[String:Any] = [:]
    var dataKeyArray:[String] = []
    var timeArrayInt:[Int] = []
    var userId:[String] = []
    var userNameArray:[String] = []
    var dataLoaded = false
    
    var ref: DatabaseReference!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainPageCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "coCell", for:indexPath ) as? MainPageCollectionViewCell
        
        
        cell?.layer.cornerRadius = 8
        cell?.layer.masksToBounds = true
        
//        var userId:String = ""
        
        
        //print(downloadData[dataKeyArray[indexPath.row]])
        if let dict = downloadData[dataKeyArray[indexPath.row]] as? [String: Any]{
            if let itemTitle = dict["item"] as? String{
                cell?.borrowItem.text = itemTitle
            }
        }
        
        if !dataLoaded{
            cell?.userName.text = ""
        }else{
            cell?.userName.text = userNameArray[indexPath.row]
        }
        //cell?.borrowItem.text = downloadData[dataKeyArray[indexPath.row]]["item"]
//        cell?.borrowItem.layer.borderColor = UIColor.blue as! CGColor;
//        cell?.borrowItem.layer.borderWidth = 1.0;
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set background color
        let myColor = UIColor(red: 0.196, green: 0.149, blue: 0.416, alpha: 1)
        self.view.backgroundColor = myColor
        UIApplication.shared.statusBarStyle = .lightContent
        
        //reference to firebase
        ref = Database.database().reference()
        
        //set collectionview
        self.mainPageCollectionView.dataSource = self
        let transparentColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        self.mainPageCollectionView.backgroundColor = transparentColor
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.mainPageCollectionView.frame.width,height: 125)
        mainPageCollectionView.collectionViewLayout = layout
        
        //getBorrowListData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //initial value
        timeArrayInt = []
        dataKeyArray = []
        userId = []
        userNameArray = []
        downloadData = [:]
        dataLoaded = false
        getBorrowListData()
        self.mainPageCollectionView.reloadData()
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
    
    //get data on firebase
    func getBorrowListData(){
        ref.child("borrowList").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let data = snapshot.value as? NSDictionary{
                self.downloadData = data as! [String : Any]
            }
            
            //add dictionary key to array
            for d in self.downloadData{
                self.dataKeyArray.append(d.key)
                
                if let dict = d.value as? [String: Any]{
                    if let uploadTimeString = dict["uploadTime"]! as? String{
                        if let timeInt = Int(uploadTimeString){
                            self.timeArrayInt.append(timeInt)
                            //print(timeInt)
                        }
                        
                        if let id = dict["userId"] as? String{
                            self.userId.append(id)
                        }
                    }
                }else{
                    print("load data error")
                }

            }
            self.sortDataViaTime(strArray: &self.dataKeyArray)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getUserData(){
        let dataCount = userId.count
        for userItem in 0..<userId.count{
            ref.child("user").child("user\(userId[userItem])").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                if let data = snapshot.value as? NSDictionary{
                    if let nameInBase = data["name"] as? String{
                        self.userNameArray.append(nameInBase)
                    }
                }
                if userItem == self.userId.count - 1{
                    self.dataLoaded = true
                    self.mainPageCollectionView.reloadData()
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        //dataLoaded = true
//        for userItem in userId{
//            userNameArray.append(self.getUserData(id: userItem))
//        }
//        self.mainPageCollectionView.reloadData()
        
    }
    
    //sort array from max to min
    func sortDataViaTime(strArray:inout [String]){
        var maxNum:Int = 0
        var maxIndex:Int = -1
        for i in 0..<strArray.count{
            maxNum = timeArrayInt[i]
            if i == strArray.count - 1{
                break
            }
            for j in i+1..<strArray.count{
                if timeArrayInt[j] > maxNum{
                    maxNum = timeArrayInt[j]
                    maxIndex = j
                }
            }
            var tempNum:Int = 0
            var tempStr:String = ""
            var tempUserId:String = ""
            
            if maxIndex != -1{
                tempNum = timeArrayInt[i]
                timeArrayInt[i] = timeArrayInt[maxIndex]
                timeArrayInt[maxIndex] = tempNum
                
                tempStr = strArray[i]
                strArray[i] = strArray[maxIndex]
                strArray[maxIndex] = tempStr
                
                tempUserId = userId[i]
                userId[i] = userId[maxIndex]
                userId[maxIndex] = tempUserId
            }
            
            maxNum = 0
            maxIndex = -1
        }
        //print(timeArrayInt)
        getUserData()
        self.mainPageCollectionView.reloadData()
    }

}
